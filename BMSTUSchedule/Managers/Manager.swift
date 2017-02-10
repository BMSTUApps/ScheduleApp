//
//  ScheduleManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 20/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase

class Manager {
    
    static let standard = Manager()
    
    static let calendar = CalendarModule()
    static let firebase = FirebaseModule()
    
    let defaults = UserDefaults.standard
    
    // MARK: Keys
    
    private let currentGroupKey = "currentGroup"
    
    // MARK: Identifiers
    
    var currentGroup: Group? {
        get {
            let groupName = defaults.string(forKey: currentGroupKey)
            
            if let newGroupName = groupName {
               return Group(name: newGroupName)
            } else {
                return nil
            }
        }
        
        set(new) {
            if let groupName = new?.name {
                defaults.set(groupName, forKey: currentGroupKey)
            }
        }
    }
    
    var userIdentifier: String? {
        get {
            return UIDevice.current.identifierForVendor?.uuidString
        }
    }
    
}
