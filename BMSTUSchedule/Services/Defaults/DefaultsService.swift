//
//  DefaultsService.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation

class DefaultsService {

    private let database = UserDefaults.standard
    
    private let userGroupIDKey = "userGroupID"
    private let userEmailKey = "userEmail"
    private let offlineModeKey = "offlineMode"

    /// User e-mail
    var userEmail: String? {
        get {
            return database.string(forKey: userEmailKey)
        }
        
        set(new) {
            guard let newEmail = new else { return }
            
            // Save email to UserDefaults
            database.set(newEmail, forKey: userEmailKey)
        }
    }
    
    /// User group ID
    var userGroupID: Model.ID? {
        get {
            let groupID = database.integer(forKey: userGroupIDKey)
            guard groupID != 0 else { return nil }
            return groupID
        }
        
        set(new) {
            guard let newID = new else { return }
            
            // Save group ID to UserDefaults
            database.set(newID, forKey: userGroupIDKey)
        }
    }
    
    /// Offline mode
    var offlineMode: Bool {
        get {
            let mode = database.bool(forKey: offlineModeKey)
            return mode
        }
        
        set(new) {
            database.set(new, forKey: offlineModeKey)
        }
    }
}
