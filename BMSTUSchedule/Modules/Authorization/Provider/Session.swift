//
//  Session.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 23/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation

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
