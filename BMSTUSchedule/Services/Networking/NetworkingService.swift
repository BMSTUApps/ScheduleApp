//
//  NetworkingService.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]
typealias RequestParameters = [String: Any]

enum Result<T, U> {
    case success(T)
    case failure(U)
    
    public var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    public var error: U? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}

class NetworkingService {
    typealias Method = (http: HTTPMethod, server: String)

    enum Error: LocalizedError {
        case invalidURL
        case invalidJSON
        case invalidSession
        case emptyPassword
        case connection(reason: String)
        case server(reason: String)
    }
    
    enum Module: String {
        case schedule
        case teachers
        case user
    }
    
    private let authorizationProvider: Authorizable
    
    private let server: String = "http://localhost"
    private let port: String = "8080"
    
    private var apiURL: URL? {
        return URL(string: "\(server):\(port)/api")
    }
    
    init(authorizationProvider: Authorizable = AuthorizationProvider()) {
        self.authorizationProvider = authorizationProvider
    }
    
    func makeRequest(module: Module, method: Method, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, session: Session? = nil, completion: @escaping (Result<JSON, Error>) -> Void) {
        guard let url = apiURL?.appendingPathComponent(module.rawValue).appendingPathComponent(method.server) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let startRequest: (Session?) -> Void = { session in

            var headers: HTTPHeaders = headers ?? [:]
            if let session = session, session.isValid {
                headers["Authorization"] = "Bearer \(session.token)"
            }
            
            Alamofire.request(url, method: method.http, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.connection(reason: error.localizedDescription)))
                    return
                    
                case .success(let value):
                    guard let json = value as? JSON else {
                        completion(.failure(.invalidJSON))
                        return
                    }
                    
                    if json["error"] != nil, let reason = json["reason"] as? String {
                        completion(.failure(.server(reason: reason)))
                        return
                    }
                    
                    completion(.success(json))
                }
            }
        }
        
        // If authorization session is expired -> try to update
        if let session = session, !session.isValid {
            authorizationProvider.updateSession(session) { session in
                guard let session = session, session.isValid else {
                    completion(.failure(.invalidSession))
                    return
                }
                
                startRequest(session)
                return
            }
        }
        
        startRequest(session)
    }
}
