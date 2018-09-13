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
    
    func getCurrentEvents() -> [Event] {
        
        let realm = try! Realm()
        
        let realmEvents = realm.objects(RealmEvent.self).sorted(byKeyPath: "date")
        if realmEvents.isEmpty {
            
            print("Save test events")
            
            try! realm.write {
                for event in testEvents {
                    realm.add(RealmEvent(event))
                }
            }
        }
        
        var events: [Event] = []
        for realmEvent in realmEvents {
            events.append(Event(realmEvent))
        }

        return events
    }
    
    fileprivate var testEvents: [Event] {
        
        // Teachers
        
        let teacherTerehov = Teacher(firstName: "Валерий", lastName: "Терехов", middleName: "Игоревич", department: "ИУ5")
        let teacherNesterov = Teacher(firstName: "Юрий", lastName: "Нестеров", middleName: "Григорьевич", department: "ИУ5")
        let teacherMyushenkov = Teacher(firstName: "Константин", lastName: "Мышенков", middleName: "Сергеевич", department: "ИУ5")
        let teacherChernenkiy = Teacher(firstName: "Михаил", lastName: "Черненький", middleName: "Валерьевич", department: "ИУ5")
    
        // Monday
        
        let event1 = Event(title: "Методы поддержки принятия решений", teacher: teacherTerehov, location: "533", kind: .lecture, date: Date("03.09")!, startTime: "10:15", endTime: "11:50")
        let event2 = Event(title: "Элементы управления в АСОИУ", teacher: teacherNesterov, location: "533", kind: .lecture, date: Date("03.09")!, startTime: "12:00", endTime: "13:35")
        let event3 = Event(title: "Безопасность жизнедеятельности", teacher: nil, location: "533", kind: .lecture, date: Date("03.09")!, startTime: "13:50", endTime: "15:25")

        
        // Tuesday

        let event4 = Event(title: "Организационное поведение и корпоративная культура", teacher: nil, location: "418ю", kind: .seminar, date: Date("04.09")!, startTime: "08:30", endTime: "10:05")
        let event5 = Event(title: "Безопасность жизнедеятельности", teacher: nil, location: "533", kind: .lecture, date: Date("04.09")!, startTime: "10:15", endTime: "11:50")
        let event6 = Event(title: "Технология конструирования ЭВМ", teacher: nil, location: "533", kind: .lecture, date: Date("04.09")!, startTime: "12:00", endTime: "13:35")
        let event7 = Event(title: "Технология конструирования ЭВМ", teacher: nil, location: "533", kind: .lecture, date: Date("04.09")!, startTime: "13:50", endTime: "15:25")
        
        // Wednesday
        
        let event8 = Event(title: "Средства проектирования АСОИУ", teacher: teacherMyushenkov, location: "362", kind: .lab, date: Date("05.09")!, startTime: "10:15", endTime: "11:50")
        let event9 = Event(title: "Средства проектирования АСОИУ", teacher: teacherMyushenkov, location: "362", kind: .lab, date: Date("05.09")!, startTime: "12:00", endTime: "13:35")
        let event10 = Event(title: "Методы поддержки принятия решений", teacher: teacherTerehov, location: "395", kind: .lab, date: Date("05.09")!, startTime: "13:50", endTime: "15:25")
        let event11 = Event(title: "Методы поддержки принятия решений", teacher: teacherTerehov, location: "395", kind: .lab, date: Date("05.09")!, startTime: "15:40", endTime: "17:15")

        // Thursday
        
        let event12 = Event(title: "Экономика", teacher: nil, location: "424ю", kind: .seminar, date: Date("06.09")!, startTime: "13:50", endTime: "15:25")
        let event13 = Event(title: "Имитационное моделирование дискретных процессов", teacher: teacherChernenkiy, location: "533", kind: .lecture, date: Date("06.09")!, startTime: "15:40", endTime: "17:15")
        let event14 = Event(title: "Средства проектирования АСОИУ", teacher: teacherMyushenkov, location: "432", kind: .seminar, date: Date("06.09")!, startTime: "17:25", endTime: "19:00")

        // Friday
        
        let event15 = Event(title: "Имитационное моделирование дискретных процессов", teacher: teacherChernenkiy, location: "903", kind: .lab, date: Date("07.09")!, startTime: "10:15", endTime: "11:50")
        let event16 = Event(title: "Имитационное моделирование дискретных процессов", teacher: teacherChernenkiy, location: "903", kind: .lab, date: Date("07.09")!, startTime: "12:00", endTime: "13:35")

        return [event1, event2, event3, event4, event5, event6, event7, event8, event9, event10, event11, event12, event13, event14, event15, event16]
    }
    
    func getTeachers() -> [Teacher] {
        
        var teachers: [Teacher] = []
        
        let realm = try! Realm()
        let realmTeachers = realm.objects(RealmTeacher.self)
        
        for realmTeacher in realmTeachers {
            if let teacher = Teacher(realmTeacher), teachers.contains(where: { (currentTeacher) -> Bool in
                return teacher.fullName == currentTeacher.fullName
            }) == false {
                
                // FIXME: Fake data
                teacher.position = "старший преподаватель"
                teacher.degree = "доцент"
                teacher.about =
                """
                Заведующий кафедрой ИУ-5, профессор, доктор технических наук.
                
                Черненький В.М. родился 13 мая 1941 г. Окончил МВТУ в 1964 году по кафедре «Математические машины» (ныне кафедра ИУ-6). В настоящее время доктор технических наук, профессор, действительный член Международной Академии Информатизации, лауреат премии Правительства Российской Федерации в области образования.
                """
                
                teachers.append(teacher)
            }
        }
        
        return teachers
    }
}

// MARK: - 3D Touch

extension AppManager {
    
    enum Shortcut: String {
        case openSchedule = "OpenSchedule" // ..opening schedule screen
        case openTeachers = "OpenTeachers" // ..opening teachers screen
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
    
    func calculateBrake(currentEvent: Event, nextEvent: Event) -> String? {

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "ru-RU")
        
        let date1 = timeFormatter.date(from: currentEvent.endTime)
        let date2 = timeFormatter.date(from: nextEvent.startTime)
        
        guard let startBrakeDate = date1, let endBrakeDate = date2 else {
            return nil
        }
        
        let interval = endBrakeDate.timeIntervalSince(startBrakeDate)
        let minutes = Int(interval / 60)
        
        return String(format: "%@ minutes break".localized, "\(minutes)")
    }
}
