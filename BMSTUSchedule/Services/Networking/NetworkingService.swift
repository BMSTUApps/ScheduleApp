//
//  NetworkingService.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import Alamofire

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

enum NetworkingError: Error {
    case invalidURL
    case invalidJSON
    case connection(reason: String)
    case server(reason: String)
}

struct Authorization {
    let accessToken: String
}

class NetworkingService {
    typealias JSON = [String: Any]
    typealias Method = (http: HTTPMethod, server: String)

    enum Module: String {
        case schedule
        case teachers
        case user
    }
    
    private let server: String = "http://localhost"
    private let port: String = "8080"
    
    private var apiURL: URL? {
        return URL(string: "\(server):\(port)/api")
    }
    
    func makeRequest(module: Module, method: Method, parameters: Parameters? = nil, authorization: Authorization? = nil, completion: @escaping (Result<JSON, NetworkingError>) -> Void) {
        guard let url = apiURL?.appendingPathComponent(module.rawValue).appendingPathComponent(method.server) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var headers: HTTPHeaders = [:]
        
        // If need authorization
        if let authorizationToken = authorization?.accessToken {
            headers["Authorization"] = authorizationToken
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
}
