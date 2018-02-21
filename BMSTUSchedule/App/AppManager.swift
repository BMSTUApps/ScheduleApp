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
    
    // MARK: -
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Keys
    
    private let currentGroupKey = "currentGroup"
    private let offlineModeKey = "offlineMode"
    
    // MARK: - Identifiers
    
    /// Current group
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
    
    func getCurrentSchedule() -> Schedule? {
        
        // If current group not exist set test group
        if currentGroup == nil {
            
            // Save test group to defaults
            currentGroup = testSchedule.group
            
            return nil
        }
        
        // If current group is nil returns nil
        guard let group = currentGroup else {
            return nil
        }

        let realm = try! Realm()
        
        // If schedule not exist return test schedule
        guard let realmSchedule = realm.objects(RealmSchedule.self).filter("group.name = '\(group.name)'").first else {
            
            print("Save test schedule")
            
            // Save test schedule to Realm
            let realmSchedule = RealmSchedule(testSchedule)
            
            try! realm.write {
                realm.add(realmSchedule)
            }
            
            return testSchedule
        }

        print("Show saved schedule")
        
        let schedule = Schedule(realmSchedule)
        return schedule
    }
    
    fileprivate var testSchedule: Schedule {
        
        let group = Group(name: "ИУ5-63")
        
        let lesson1 = Lesson(title: "English", teacher: "Трошина О.В.", room: "401л", kind: .seminar, startTime: "8:30", endTime: "10:05")
        let lesson2 = Lesson(title: "Network Software", teacher: "Семкин П.С.", room: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let lesson3 = Lesson(title: "Multimedia Technology", teacher: "Афанасьев Г.И.", room: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let lesson4 = Lesson(title: "Philosophy", teacher: nil, room: "502", kind: .seminar, startTime: "13:50", endTime: "15:25")
        let lesson5 = Lesson(title: "Swimming pool", teacher: "Васющенкова Т.С.", room: "Sports Complex", kind: .undefined, startTime: "15:50", endTime: "17:25")
        
        let monday = Day(title: .monday, lessons: [lesson1, lesson2, lesson3, lesson4, lesson5], date: Date())
        
        let lesson6 = Lesson(title: "Discrete optimization methods", teacher: "Иванов А.О.", room: "306ю", kind: .seminar, startTime: "8:30", endTime: "10:05")
        let lesson7 = Lesson(title: "Discrete optimization methods", teacher: "Иванов А.О.", room: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let lesson8 = Lesson(title: "Description of the life cycle processes of ASOIS", teacher: "Черненький В. М.", room: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let lesson9 = Lesson(title: "Description of the life cycle processes of ASOIS", teacher: "Черненький В. М.", room: "515ю", kind: .lecture, startTime: "13:50", endTime: "15:25")
        let lesson10 = Lesson(title: "Swimming pool", teacher: "Васющенкова Т.С.", room: "Sports Complex", kind: .undefined, startTime: "15:50", endTime: "17:25")
        
        let numeratorTuesday = Day(title: .tuesday, lessons: [lesson6, lesson7, lesson8, lesson9, lesson10], date: Date())
        
        let lesson11 = Lesson(title: "Military Training", teacher: "Лясковский В.Л.", room: "214", kind: .seminar, startTime: "10:15", endTime: "11:50")
        let lesson12 = Lesson(title: "Military Training", teacher: "Горелов В.И", room: "214", kind: .seminar, startTime: "12:00", endTime: "13:35")
        let lesson13 = Lesson(title: "Military Training", teacher: "Амелько А.В.", room: "214", kind: .seminar, startTime: "13:50", endTime: "15:25")
        let lesson14 = Lesson(title: "Military Training", teacher: "Горелов В.И", room: "208", kind: .seminar, startTime: "15:40", endTime: "17:15")
        let lesson15 = Lesson(title: "Multimedia Technology", teacher: "Белоногов И.Б.", room: "903", kind: .lab, startTime: "17:25", endTime: "19:00")
        let lesson16 = Lesson(title: "Multimedia Technology", teacher: "Белоногов И.Б.", room: "903", kind: .lab, startTime: "19:10", endTime: "20:45")
        
        let numeratorWednesday = Day(title: .wednesday, lessons: [lesson11, lesson12, lesson13, lesson14, lesson15, lesson16], date: Date())
        
        let lesson17 = Lesson(title: "Network technologies in ASOIS", teacher: "Антонов А.И.", room: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let lesson18 = Lesson(title: "Philosophy", teacher: "Ивлев В.Ю.", room: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let lesson19 = Lesson(title: "Supercomputer", teacher: "Калистратов А.П.", room: "515ю", kind: .lecture, startTime: "13:50", endTime: "15:25")
        
        let numeratorThursday = Day(title: .thursday, lessons: [lesson17, lesson18, lesson19], date: Date())
        
        let lesson20 = Lesson(title: "Network Software", teacher: "Семкин П.С.", room: "903", kind: .lab, startTime: "8:30", endTime: "10:05")
        let lesson21 = Lesson(title: "Network Software", teacher: "Семкин П.С.", room: "903", kind: .lab, startTime: "10:15", endTime: "11:50")
        
        let numeratorSaturday = Day(title: .saturday, lessons: [lesson20, lesson21], date: Date())
        
        let lesson22 = Lesson(title: "Description of the life cycle processes of ASOIS", teacher: "Черненький М. В.", room: "395", kind: .seminar, startTime: "13:50", endTime: "15:25")
        
        let denominatorTuesday = Day(title: .tuesday, lessons: [lesson6, lesson7, lesson8, lesson22, lesson10], date: Date())
        
        let denominatorWednesday = Day(title: .wednesday, lessons: [lesson11, lesson12, lesson13, lesson14], date: Date())
        
        let lesson23 = Lesson(title: "Supercomputer", teacher: "Калистратов А.П.", room: "903", kind: .lab, startTime: "15:40", endTime: "17:15")
        
        let denominatorThursday = Day(title: .thursday, lessons: [lesson17, lesson18, lesson19, lesson23], date: Date())
        
        let lesson24 = Lesson(title: "Network technologies in ASOIS", teacher: "Аксёнов А.Н", room: "362", kind: .lab, startTime: "8:30", endTime: "10:05")
        let lesson25 = Lesson(title: "Network technologies in ASOIS", teacher: "Аксёнов А.Н", room: "362", kind: .lab, startTime: "10:15", endTime: "11:50")
        
        let denominatorFriday = Day(title: .friday, lessons: [lesson24, lesson25], date: Date())
        
        let numerator = Week(number: 0, kind: .numerator, days: [monday, numeratorTuesday, numeratorWednesday, numeratorThursday, numeratorSaturday])
        let denominator = Week(number: 0, kind: .denominator, days: [monday, denominatorTuesday, denominatorWednesday, denominatorThursday, denominatorFriday])
        
        let schedule = Schedule(group: group, weeks: [numerator, denominator])
        
        return schedule
    }
}

// MARK: - 3D Touch

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

// MARK: - Helpers

extension AppManager {
    
    func calculateBrake(lesson1: Lesson, lesson2: Lesson) -> String? {

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "ru-RU")
        
        let date1 = timeFormatter.date(from: lesson1.endTime)
        let date2 = timeFormatter.date(from: lesson2.startTime)
        
        guard let startBrakeDate = date1, let endBrakeDate = date2 else {
            return nil
        }
        
        let interval = endBrakeDate.timeIntervalSince(startBrakeDate)
        let minutes = Int(interval / 60)
        
        return String(format: "%@ minutes break".localized, "\(minutes)")
    }
}
