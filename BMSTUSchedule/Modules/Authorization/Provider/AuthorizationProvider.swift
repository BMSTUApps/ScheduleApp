//
//  AuthorizationProvider.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Alamofire

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

    func signUp(email: String, password: String, firstName: String, lastName: String, scheduleID: Model.ID, completion: @escaping (Session?) -> Void) {
        
        let parameters: Parameters = [
            "email": email,
            "password": password,
            "first_name": firstName,
            "last_name": lastName,
            "template_schedule_id": scheduleID
        ]
        
        network.makeRequest(module: .user, method: (.post, "sign_up"), parameters: parameters) { (result) in
            switch result {
            case .failure(let error):
                // TODO: Handle error
                completion(nil)
                return
            case .success(let json):
                guard json["id"] != nil else {
                    // TODO: Handle error
                    completion(nil)
                    return
                }
                
                self.login(email: email, password: password, completion: { session in
                    completion(session)
                    return
                })
            }
        }
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
                
                print("Authorized with token '\(newSession.token)'")
                
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
    
    func getAvailableGroups(completion: @escaping ([Group]?) -> Void) {
        
        network.makeRequest(module: .schedule, method: (.get, "templates")) { result in
            switch result {
            case .failure(let error):
                // TODO: Handle error
                break
            case .success(let json):
                guard let rawGroups = json["result"] as? [JSON] else {
                    completion(nil)
                    return
                }
                
                let groups = rawGroups.compactMap({ raw in
                    return Group(json: raw)
                }).sorted(by: { (first, second) -> Bool in
                    if first.department == second.department {
                        return first.number < second.number
                    }
                    
                    return first.department < second.department
                })
                
                completion(groups)
            }
        }
    }
}
