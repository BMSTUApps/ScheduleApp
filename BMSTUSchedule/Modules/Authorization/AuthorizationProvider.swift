//
//  AuthorizationProvider.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import Alamofire

struct Session {
    let email: String
    let token: String
    let expiresAt: Date
    
    var isValid: Bool {
        return expiresAt > .today
    }
    
    private enum Key: String {
        case token
        case expiresAt = "expires_at"
    }
    
    // MARK: Initialization

    init(email: String, token: String, expiresAt: Date) {
        self.email = email
        self.token = token
        self.expiresAt = expiresAt
    }
    
    init?(email: String, tokenJSON: JSON) {
        guard let token = tokenJSON[Key.token.rawValue] as? String,
            let rawExpiresAt = tokenJSON[Key.expiresAt.rawValue] as? String,
            let expiresAt = Date(rawExpiresAt, format: "yyyy-MM-dd HH:mm:ss") else {
                return nil
        }

        self.email = email
        self.token = token
        self.expiresAt = expiresAt
    }
}

protocol Authorizable {
    func updateSession(_ session: Session, completion: @escaping (Session?) -> Void)
}

class AuthorizationProvider: Authorizable {

    private var defaults: DefaultsService {
        return AppManager.shared.defaultsService
    }
    
    private var keychain: KeychainService {
        return AppManager.shared.keychainService
    }
    
    private var network: NetworkingService {
        return AppManager.shared.networkingService
    }

    func login(email: String, password: String, completion: @escaping (Session?) -> Void) {
        
        let secureString = "\(email):\(password)"
        let base64String = Data(secureString.utf8).base64EncodedString()
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(base64String)"
        ]

        network.makeRequest(module: .user, method: (.post, "login"), headers: headers) { (result) in
            switch result {
            case .failure(let error):
                // TODO: Handle error
                completion(nil)
                return
            case .success(let json):
                guard let newSession = Session(email: email, tokenJSON: json) else {
                    // TODO: Handle error
                    completion(nil)
                    return
                }
                
                // Save passport to KeyChain
                self.keychain.savePassword(password, for: email)
                
                // Save session to UserDefaults
                self.defaults.session = newSession
                
                completion(newSession)
            }
        }
    }
    
    func logout() {
        
        // Delete session from UserDefaults
        defaults.session = nil
    }
    
    func updateSession(_ session: Session, completion: @escaping (Session?) -> Void) {
        guard let password = keychain.getPassword(for: session.email) else {
            completion(nil)
            return
        }
        
        login(email: session.email, password: password) { updatedSession in
            completion(updatedSession)
        }
    }
}
