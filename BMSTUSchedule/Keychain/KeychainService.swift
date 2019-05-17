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
    
    func getToken(for email: String) throws -> String? {
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
                let tokenData = queriedItem[String(kSecValueData)] as? Data,
                let token = String(data: tokenData, encoding: .utf8)
                else {
                    throw Error.conversionError
            }
            return token
        case errSecItemNotFound:
            return nil
        default:
            throw error(from: status)
        }
    }
    
    func saveToken(_ token: String, for email: String) throws {
        
        guard let encodedToken = token.data(using: .utf8) else {
            throw Error.conversionError
        }
        
        var query: [String: Any] = [:]
        query[String(kSecAttrAccount)] = email
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedToken
            
            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw error(from: status)
            }
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedToken
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
    }
    
    func removeToken(for email: String) throws {
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
