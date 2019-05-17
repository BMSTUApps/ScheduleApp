//
//  KeychainService.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import Security

class KeychainService {
    
    enum Error: LocalizedError {
        case conversionError
        case unhandledError(reason: String)
    }
    
    func getPassword(for email: String) throws -> String? {
        var query: [String: Any] = [:]
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrAccount)] = email
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }
        
        switch status {
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let passwordData = queriedItem[String(kSecValueData)] as? Data,
                let password = String(data: passwordData, encoding: .utf8)
                else {
                    throw Error.conversionError
            }
            return password
        case errSecItemNotFound:
            return nil
        default:
            throw error(from: status)
        }
    }
    
    func savePassword(_ password: String, for email: String) throws {
        
        guard let encodedPassword = password.data(using: .utf8) else {
            throw Error.conversionError
        }
        
        var query: [String: Any] = [:]
        query[String(kSecAttrAccount)] = email
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedPassword
            
            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw error(from: status)
            }
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedPassword
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
    }
    
    func removePassword(for email: String) throws {
        var query: [String: Any] = [:]
        query[String(kSecAttrAccount)] = email
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }
    
    private func error(from reason: OSStatus) -> Error {
        var message: String?
        
        if #available(iOS 11.3, *) {
            message = SecCopyErrorMessageString(reason, nil) as String?
        }
        
        return Error.unhandledError(reason: message ?? NSLocalizedString("Unhandled Error", comment: ""))
    }
}
