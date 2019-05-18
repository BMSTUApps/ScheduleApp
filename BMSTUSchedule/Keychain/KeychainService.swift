//
//  KeychainService.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainService {
    
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    func getPassword(for email: String) -> String? {
        return keychain[email]
    }
    
    func savePassword(_ password: String, for email: String) {
        keychain[email] = password
    }
    
    func removePassword(for email: String) {
        try? keychain.remove(email)
    }
}
