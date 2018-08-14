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
    
        // Teachers
        
        let teacherTroshina = Teacher(firstName: "Ольга", lastName: "Трошина", middleName: "Валерьевна", department: "")
        let teacherSemkin = Teacher(firstName: "Пётр", lastName: "Семкин", middleName: "Степанович", department: "ИУ5")
        let teacherAfanasyev = Teacher(firstName: "Геннадий", lastName: "Афанасьев", middleName: "Иванович", department: "ИУ5")
        let teacherVasuschenkova = Teacher(firstName: "Татьяна", lastName: "Васющенкова", middleName: "Стефановна", department: "")
        let teacherIvanov = Teacher(firstName: "Александр", lastName: "Иванов", middleName: "Олегович", department: "")
        let teacherChernenkiyV = Teacher(firstName: "Владимир", lastName: "Черненький", middleName: "Михайлович", department: "ИУ5")
        let teacherLyaskovskiy = Teacher(firstName: "Вячеслав", lastName: "Лясковский", middleName: "Людвигович", department: "ВК1")
        let teacherGorelov = Teacher(firstName: "Владимир", lastName: "Горелов", middleName: "Игоревич", department: "ВК1")
        let teacherAmelko = Teacher(firstName: "Александр", lastName: "Амелько", middleName: "Владимирович", department: "ВК1")
        let teacherBelonogov = Teacher(firstName: "Игорь", lastName: "Белоногов", middleName: "Борисович", department: "ИУ5")
        let teacherAntonov = Teacher(firstName: "Артём", lastName: "Антонов", middleName: "Ильич", department: "ИУ5")
        let teacherIvlev = Teacher(firstName: "Вячеслав", lastName: "Ивлев", middleName: "Юрьевич", department: "")
        let teacherKalistratov = Teacher(firstName: "Алексей", lastName: "Калистратов", middleName: "Павлович", department: "ИУ5")
        let teacherChernenkiyМ = Teacher(firstName: "Михаил", lastName: "Черненький", middleName: "Владимирович", department: "ИУ5")
        let teacherAksenov = Teacher(firstName: "Андрей", lastName: "Аксёнов", middleName: "Николаевич", department: "ИУ5")

        // Monday
        
        let event1 = Event(title: "English", teacher: teacherTroshina, location: "401л", kind: .seminar, startTime: "8:30", endTime: "10:05")
        let event2 = Event(title: "Network Software", teacher: teacherSemkin, location: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let event3 = Event(title: "Multimedia Technology", teacher: teacherAfanasyev, location: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let event4 = Event(title: "Philosophy", teacher: nil, location: "502", kind: .seminar, startTime: "13:50", endTime: "15:25")
        let event5 = Event(title: "Swimming pool", teacher: teacherVasuschenkova, location: "СК", kind: .other, startTime: "15:50", endTime: "17:25")
        
        let monday = Day(title: .monday, events: [event1, event2, event3, event4, event5], date: Date())
        
        // Tuesday (numerator)
        
        let event6 = Event(title: "Discrete optimization methods", teacher: teacherIvanov, location: "306ю", kind: .seminar, startTime: "8:30", endTime: "10:05")
        let event7 = Event(title: "Discrete optimization methods", teacher: teacherIvanov, location: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let event8 = Event(title: "Description of the life cycle processes of ASOIS", teacher: teacherChernenkiyV, location: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let event9 = Event(title: "Description of the life cycle processes of ASOIS", teacher: teacherChernenkiyV, location: "515ю", kind: .lecture, startTime: "13:50", endTime: "15:25")
        let event10 = Event(title: "Swimming pool", teacher: teacherVasuschenkova, location: "СК", kind: .other, startTime: "15:50", endTime: "17:25")
        
        let numeratorTuesday = Day(title: .tuesday, events: [event6, event7, event8, event9, event10], date: Date())
        
        // Wednesday (numerator)
        
        let event11 = Event(title: "Military Training", teacher: teacherLyaskovskiy, location: "214", kind: .other, startTime: "10:15", endTime: "11:50")
        let event12 = Event(title: "Military Training", teacher: teacherGorelov, location: "214", kind: .other, startTime: "12:00", endTime: "13:35")
        let event13 = Event(title: "Military Training", teacher: teacherAmelko, location: "214", kind: .other, startTime: "13:50", endTime: "15:25")
        let event14 = Event(title: "Military Training", teacher: teacherGorelov, location: "208", kind: .other, startTime: "15:40", endTime: "17:15")
        let event15 = Event(title: "Multimedia Technology", teacher: teacherBelonogov, location: "903", kind: .lab, startTime: "17:25", endTime: "19:00")
        let event16 = Event(title: "Multimedia Technology", teacher: teacherBelonogov, location: "903", kind: .lab, startTime: "19:10", endTime: "20:45")
        
        let numeratorWednesday = Day(title: .wednesday, events: [event11, event12, event13, event14, event15, event16], date: Date())
        
        // Thursday (numerator)
        
        let event17 = Event(title: "Network technologies in ASOIS", teacher: teacherAntonov, location: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let event18 = Event(title: "Philosophy", teacher: teacherIvlev, location: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let event19 = Event(title: "Supercomputer", teacher: teacherKalistratov, location: "515ю", kind: .lecture, startTime: "13:50", endTime: "15:25")
        
        let numeratorThursday = Day(title: .thursday, events: [event17, event18, event19], date: Date())
        
        // Saturday (numerator)
        
        let event20 = Event(title: "Network Software", teacher: teacherSemkin, location: "903", kind: .lab, startTime: "8:30", endTime: "10:05")
        let event21 = Event(title: "Network Software", teacher: teacherSemkin, location: "903", kind: .lab, startTime: "10:15", endTime: "11:50")
        
        let numeratorSaturday = Day(title: .saturday, events: [event20, event21], date: Date())
        
        let event22 = Event(title: "Description of the life cycle processes of ASOIS", teacher: teacherChernenkiyМ, location: "395", kind: .seminar, startTime: "13:50", endTime: "15:25")
        
        // Tuesday (denominator)
        
        let denominatorTuesday = Day(title: .tuesday, events: [event6, event7, event8, event22, event10], date: Date())
        
        // Wednesday (denominator)

        let denominatorWednesday = Day(title: .wednesday, events: [event11, event12, event13, event14], date: Date())
        
        // Thursday (denominator)
        
        let event23 = Event(title: "Supercomputer", teacher: teacherKalistratov, location: "903", kind: .lab, startTime: "15:40", endTime: "17:15")
        
        let denominatorThursday = Day(title: .thursday, events: [event17, event18, event19, event23], date: Date())
        
        // Friday (denominator)
        
        let event24 = Event(title: "Network technologies in ASOIS", teacher: teacherAksenov, location: "362", kind: .lab, startTime: "8:30", endTime: "10:05")
        let event25 = Event(title: "Network technologies in ASOIS", teacher: teacherAksenov, location: "362", kind: .lab, startTime: "10:15", endTime: "11:50")
        
        let denominatorFriday = Day(title: .friday, events: [event24, event25], date: Date())
        
        let numerator = Week(number: 0, kind: .numerator, days: [monday, numeratorTuesday, numeratorWednesday, numeratorThursday, numeratorSaturday])
        let denominator = Week(number: 0, kind: .denominator, days: [monday, denominatorTuesday, denominatorWednesday, denominatorThursday, denominatorFriday])
        
        let schedule = Schedule(group: group, weeks: [numerator, denominator])
        
        return schedule
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
