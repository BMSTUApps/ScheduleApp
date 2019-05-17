//
//  ScheduleManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 20/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase
import RealmSwift

class AppManager {
    
    static let shared = AppManager()
    
    // MARK: Services

    let notificationsService = NotificationsService()
    let realmService = RealmService()
    let networkingService = NetworkingService()
    
    // MARK: -

    
    func configureOnLaunching() {
        
        // Configure firebase
        FirebaseApp.configure()
        
        // Configure notifications
        notificationsService.registerForRemoteNotifications()
    }
    
    // MARK: -
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Keys
    
    private let currentGroupKey = "currentGroup"
    private let offlineModeKey = "offlineMode"
    
    // MARK: - Identifiers
    
    /// Current group
    var currentGroup: Group? {
        get {
            guard let groupID = defaults.string(forKey: currentGroupKey) else { return nil }
            return realmService.getGroup(id: groupID)
        }
        
        set(new) {
            guard let newGroup = new else { return }
            
            // Save group ID to UserDefaults
            defaults.set(newGroup.id, forKey: currentGroupKey)
            
            // Save group to realm
            realmService.saveGroup(newGroup)
        }
    }
    
    /// Unique user identifier
    var userIdentifier: String? {
        get {
            if let identifier = UIDevice.current.identifierForVendor?.uuidString {
                return "user(\(identifier))"
            } else {
                return nil
            }
        }
    }
    
    /// Offline mode flag
    var offlineMode: Bool {
        get {
            let mode = defaults.bool(forKey: offlineModeKey)
            return mode
        }
        set(new) {
            defaults.set(new, forKey: offlineModeKey)
        }
    }
    
    // MARK: - Schedule
    
    func getEvents() -> [Event] {
        
        let realm = try! Realm()
        
        let realmEvents = realm.objects(RealmEvent.self).sorted(byKeyPath: "date")
        
        var events: [Event] = []
        for realmEvent in realmEvents {
            events.append(Event(realmEvent))
        }

        return events
    }
    
    func getTeachers() -> [Teacher] {
        
        var teachers: [Teacher] = []
        
        let realm = try! Realm()
        let realmTeachers = realm.objects(RealmTeacher.self)
        
        for realmTeacher in realmTeachers {
            let teacher = Teacher(realmTeacher)
            if teachers.contains(where: { (currentTeacher) -> Bool in
                return teacher.fullName == currentTeacher.fullName
            }) == false {
                teachers.append(teacher)
            }
        }
        
        return teachers
    }
}

// MARK: - 3D Touch

extension AppManager {
    
    enum Action: String {
        case openSchedule
        case openTeachers
    }
    
    func perfomAction(_ action: Action) -> Bool {
        
        var quickActionHandled = false
        
        switch action {
            
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
        
        return quickActionHandled
    }
    
    /// Support 3D-touch shortcuts
    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        let identifier = shortcutItem.type.components(separatedBy: ".").last!
        if let action = Action.init(rawValue: identifier) {
            return perfomAction(action)
        }
        
        return false
    }
    
    /// Support Siri intents
    func handleIntent(userActivity: NSUserActivity) -> Bool {
     
        let identifier = userActivity.activityType.components(separatedBy: ".").last!
        if let action = Action.init(rawValue: identifier) {
            return perfomAction(action)
        }
        
        return true
    }
}
