//
//  ScheduleManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 20/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase

class AppManager {
    
    static let shared = AppManager()
    
    // MARK: -
    
    let defaults = UserDefaults.standard
    
    // MARK: - Keys
    
    private let currentGroupKey = "currentGroup"
    private let offlineModeKey = "offlineMode"
    
    // MARK: - Identifiers
    
    // Current selected group
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
    
    // Unique user identifier
    var userIdentifier: String? {
        get {
            if let identifier = UIDevice.current.identifierForVendor?.uuidString {
                return "user(\(identifier))"
            } else {
                return nil
            }
        }
    }
    
    // Offline mode flag
    var offlineMode: Bool {
        get {
            let mode = defaults.bool(forKey: offlineModeKey)
            return mode
        }
        set(new) {
            defaults.set(new, forKey: offlineModeKey)
        }
    }
}

extension AppManager {
    
    enum Shortcut: String {
        case openSchedule = "OpenSchedule"
        case openTeachers = "OpenTeachers"
    }
    
    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var quickActionHandled = false
        let type = shortcutItem.type.components(separatedBy: ".").last!
        if let shortcutType = Shortcut.init(rawValue: type) {
            
            switch shortcutType {
            case .openSchedule:
                
                guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                    return quickActionHandled
                }
                
                if let tababarController = rootViewController as? UITabBarController {
                    tababarController.selectedIndex = 0
                }
                
                quickActionHandled = true
                
            case .openTeachers:
                
                guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                    return quickActionHandled
                }
                
                if let tababarController = rootViewController as? UITabBarController {
                    tababarController.selectedIndex = 1
                }
                
                quickActionHandled = true
            }
        }
        
        return quickActionHandled
    }
}
