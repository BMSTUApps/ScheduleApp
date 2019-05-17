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
    let keychainService = KeychainService()
    let defaultsService = DefaultsService()
    
    // MARK: Configuration
    
    func configureOnLaunching() {
        
        // Configure firebase
        FirebaseApp.configure()
        
        // Configure notifications
        notificationsService.registerForRemoteNotifications()
    }
    
    // MARK: Authorization
    
    struct Session {
        let email: String
        let token: String
    }
    
    enum AuthorizationState {
        case authorized(session: Session)
        case template(group: Group)
        case unauthorized
    }
    
    var authorizationState: AuthorizationState {
        
        // Try to get user email & session token
        if let email = defaultsService.userEmail, let token = try? keychainService.getToken(for: email), let unwrappedToken = token {
            let session = Session(email: email, token: unwrappedToken)
            return .authorized(session: session)
        } else if let group = currentGroup {
            return .template(group: group)
        } else {
            return .unauthorized
        }
    }
    
    // MARK: Identifiers
    
    /// Current group
    var currentGroup: Group? {
        get {
            guard let groupID = defaultsService.userGroupID else { return nil }
            return realmService.getGroup(id: groupID)
        }
        
        set(new) {
            guard let newGroup = new else { return }
            
            // Save group ID to UserDefaults
            defaultsService.userGroupID = newGroup.id
            
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
    
    /// Offline mode
    var offlineMode: Bool {
        get {
            return defaultsService.offlineMode
        }
        set(new) {
            defaultsService.offlineMode = new
        }
    }
    
    // MARK: -
    
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
