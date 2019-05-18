//
//  AuthorizationProvider.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 18/05/2019.
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

    func updateSession(_ session: Session, completion: @escaping (Session?) -> Void) {
        guard let password = try? keychain.getPassword(for: session.email), let unwrappedPassword = password else {
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "\(session.email) \(unwrappedPassword)"
        ]
        
        network.makeRequest(module: .user, method: (.post, "login"), headers: headers) { (result) in
            switch result {
            case .failure(let error):
                // TODO: Handle error
                completion(nil)
                return
            case .success(let json):
                break
            }
        }
    }
    
}
