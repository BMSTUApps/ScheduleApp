//
//  FirebaseModule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation
import Firebase

class FirebaseModule {

    // MARK: - Server paths
    
    private let datesPath     = "dates"
    private let schedulesPath = "schedules"
    private let groupsPath    = "groups"
    
    private let startTermDatePath = "startTermDate"
    private let endTermDatePath   = "endTermDate"
    
    // MARK: - Configure
    
    func configure() {
        
        // Set firebase
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = Manager.standard.offlineMode
        
        // Update dates
        getStartTermDate { (startTermDate) in /* Update schedule */ }
        getEndTermDate { (endTermDate) in /* Update schedule */ }
    }
    
    // MARK: - Get
    
    // Date
    
    func getDate(path: String, success: @escaping (Date?) -> ()) {
        let dateRef = FIRDatabase.database().reference(withPath: datesPath).child(path)
        
        dateRef.observe(.value, with: { snapshot in
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "RU_ru")
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            if let date = dateFormatter.date(from: snapshot.value as! String) {
                UserDefaults.standard.set(snapshot.value as! String, forKey: path)
                success(date)
            } else {
                success(nil)
            }
        })
    }
    
    // Start Term Date
    func getStartTermDate(success: @escaping (Date?) -> ()) {
        getDate(path: startTermDatePath) { (startTermDate) in
            success(startTermDate)
        }
    }
    
    // End Term Date
    func getEndTermDate(success: @escaping (Date?) -> ()) {
        getDate(path: endTermDatePath) { (startTermDate) in
            success(startTermDate)
        }
    }
    
    // Group
    
    func getGroups(success: @escaping ([Group]) -> ()) {
        let groupsRef = FIRDatabase.database().reference(withPath: groupsPath)
        
        // Get groups
        groupsRef.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.value is NSNull {
                success([])
            } else {
                var groups: [Group] = []
                
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snapshot in snapshots {
                        let group = Group(snapshot: snapshot)
                        groups.append(group)
                    }
                    success(groups)
                } else {
                    success([])
                }
            }
        })
    }
    
    // Schedule
    
    func getSchedule(identifier: String, success: @escaping (Schedule) -> ()) {
        
        // Set path to schedule
        let scheduleRef = FIRDatabase.database().reference().child(schedulesPath).child(identifier)
        
        // Get schedule
        scheduleRef.observe(.value, with: { snapshot in
            let schedule = Schedule()
            
            // Parse schedule
            for weekTypeSnap in snapshot.children {
                var days: [Day] = []
                
                for daySnap in (weekTypeSnap as! FIRDataSnapshot).children {
                    let dayTitleString = (daySnap as! FIRDataSnapshot).key
                    var day = Day(title: .monday, lessons: [])
                    if let dayTitle = Day.Title(rawValue: dayTitleString) {
                        day = Day(title: dayTitle, lessons: [])
                    }
                    
                    var lessons: [Lesson] = []
                    for lessonSnap in (daySnap as! FIRDataSnapshot).children {
                        let lesson = Lesson(snapshot: lessonSnap as! FIRDataSnapshot)
                        
                        if lessons.index(of: lesson) != nil {
                            // Found copy!
                        } else {
                            lessons.append(lesson)
                        }
                    }
                    
                    day.lessons = lessons
                    days.append(day)
                }
                
                // Sort days by title
                var sortedDays: [Day] = []
                for dayTitle in Day.Title.allValues {
                    if let day = days.filter({$0.title == dayTitle}).first {
                        
                        // Sort lessons by start time
                        day.lessons = day.lessons.sorted(by: {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "HH:mm"
                            
                            let startDate1 = dateFormatter.date(from: $0.0.startTime!)
                            let startDate2 = dateFormatter.date(from: $0.1.startTime!)
                            
                            return startDate1! < startDate2!
                        })
                        sortedDays.append(day)
                    }
                }
                days = sortedDays
                
                if let weekKind = Week.Kind(rawValue: (weekTypeSnap as! FIRDataSnapshot).key) {
                    switch weekKind{
                    case .numerator:
                        schedule.numeratorWeek = Week(kind: .numerator, days: days)
                    case .denominator:
                        schedule.denominatorWeek = Week(kind: .denominator, days: days)
                    }
                }
            }
            success(schedule)
        })
    }
    
    func getSchedule(group: Group, success: @escaping (Schedule) -> ()) {
        
        self.getSchedule(identifier: group.identifier) { schedule in
            success(schedule)
        }
    }
    
    // MARK: - Set
    
    // Group
    
    func addGroup(group: Group) {
        let groupRef = FIRDatabase.database().reference(withPath: groupsPath).child(group.identifier)
        groupRef.setValue(group.toAnyObject())
    }
    
    // Lesson
    
    func addLesson(lesson: Lesson, identifier: String, weekKind: Week.Kind, dayTitle: Day.Title) {
        let lessonRef = FIRDatabase.database().reference(withPath: schedulesPath).child(identifier).child(weekKind.rawValue).child(dayTitle.rawValue).child(lesson.generateKey())
        lessonRef.setValue(lesson.toAnyObject())
    }
    
    func addLesson(lesson: Lesson, group: Group, weekKind: Week.Kind, dayTitle: Day.Title) {
        
        // Add group
        self.addGroup(group: group)
        
        // Add lesson
        self.addLesson(lesson: lesson, identifier: group.identifier, weekKind: weekKind, dayTitle: dayTitle)
    }
    
    func removeLesson(lesson: Lesson, identifier: String, weekKind: Week.Kind, dayTitle: Day.Title) {
        let lessonRef = FIRDatabase.database().reference(withPath: schedulesPath).child(identifier).child(weekKind.rawValue).child(dayTitle.rawValue).child(lesson.generateKey())
        lessonRef.removeValue()
    }
    
    func removeLesson(lesson: Lesson, group: Group, weekKind: Week.Kind, dayTitle: Day.Title) {
        self.removeLesson(lesson: lesson, identifier: group.identifier, weekKind: weekKind, dayTitle: dayTitle)
    }
    
    // Schedule
    
    func addSchedule(schedule: Schedule, identifier: String) {
        
        // Add schedule
        let scheduleRef = FIRDatabase.database().reference(withPath: schedulesPath).child(identifier)
        
        // Set numerator week
        let numeratorWeekRef = scheduleRef.child(Week.Kind.numerator.rawValue)
        for day in schedule.numeratorWeek.days {
            let dayRef = numeratorWeekRef.child(day.title.rawValue)
            for lesson in day.lessons {
                let lessonRef = dayRef.child(lesson.generateKey())
                lessonRef.setValue(lesson.toAnyObject())
            }
        }
        
        // Set denominator week
        let denominatorWeekRef = scheduleRef.child(Week.Kind.denominator.rawValue)
        for day in schedule.denominatorWeek.days {
            let dayRef = denominatorWeekRef.child(day.title.rawValue)
            for lesson in day.lessons {
                let lessonRef = dayRef.child(lesson.generateKey())
                lessonRef.setValue(lesson.toAnyObject())
            }
        }
    }
    
    func addSchedule(schedule: Schedule, group: Group) {
        
        // Add group
        self.addGroup(group: group)
        
        // Add schedule
        self.addSchedule(schedule: schedule, identifier: group.identifier)
    }
    
    // MARK: - Test data
    
    func testSchedule() -> Schedule {
        
        let numeratorMonday = Day(title: .monday,
                                  lessons: [Lesson(title: "Базы данных",
                                                   teacher: "",
                                                   room: "306э/1",
                                                   type: .lab,
                                                   startTime: "10:15",
                                                   endTime: "11:50"),
                                            Lesson(title: "Базы данных",
                                                   teacher: "",
                                                   room: "306э/1",
                                                   type: .lab,
                                                   startTime: "12:00",
                                                   endTime: "13:35"),
                                            Lesson(title: "Политология",
                                                   teacher: "",
                                                   room: "720л",
                                                   type: .lecture,
                                                   startTime: "13:50",
                                                   endTime: "15:25"),
                                            Lesson(title: "Электроника",
                                                   teacher: "Белодедов М. В.",
                                                   room: "615л",
                                                   type: .seminar,
                                                   startTime: "15:40",
                                                   endTime: "17:15")])
        
        let denominatorMonday = Day(title: .monday,
                                    lessons: [Lesson(title: "Схемотехника дискретных устройств",
                                                     teacher: "",
                                                     room: "700",
                                                     type: .lab,
                                                     startTime: "8:30",
                                                     endTime: "10:05"),
                                              Lesson(title: "Схемотехника дискретных устройств",
                                                     teacher: "",
                                                     room: "700",
                                                     type: .lab,
                                                     startTime: "10:15",
                                                     endTime: "11:50"),
                                              Lesson(title: "Политология",
                                                     teacher: "",
                                                     room: "218л",
                                                     type: .seminar,
                                                     startTime: "12:00",
                                                     endTime: "13:35"),
                                              Lesson(title: "Политология",
                                                     teacher: "",
                                                     room: "720л",
                                                     type: .lecture,
                                                     startTime: "13:50",
                                                     endTime: "15:25")])
        
        let tuesday = Day(title: .tuesday,
                          lessons: [Lesson(title: "Военная подготовка",
                                           teacher: "",
                                           room: "ВК",
                                           type: .lecture,
                                           startTime: "8:30",
                                           endTime: "10:05"),
                                    Lesson(title: "Военная подготовка",
                                           teacher: "",
                                           room: "ВК",
                                           type: .lecture,
                                           startTime: "10:15",
                                           endTime: "11:50"),
                                    Lesson(title: "Военная подготовка",
                                           teacher: "",
                                           room: "ВК",
                                           type: .lecture,
                                           startTime: "12:00",
                                           endTime: "13:35"),
                                    Lesson(title: "Военная подготовка",
                                           teacher: "",
                                           room: "ВК",
                                           type: .seminar,
                                           startTime: "13:50",
                                           endTime: "15:25")])
        
        let numeratorWednesday = Day(title: .wednesday,
                                     lessons: [Lesson(title: "Схемотехника дискретных устройств",
                                                      teacher: "Спиридонов С. Б.",
                                                      room: "501ю",
                                                      type: .lecture,
                                                      startTime: "8:30",
                                                      endTime: "10:05"),
                                               Lesson(title: "Схемотехника дискретных устройств",
                                                      teacher: "Спиридонов С. Б.",
                                                      room: "501ю",
                                                      type: .lecture,
                                                      startTime: "10:15",
                                                      endTime: "11:50"),
                                               Lesson(title: "Базы данных",
                                                      teacher: "Ревунков Г. И.",
                                                      room: "501ю",
                                                      type: .lecture,
                                                      startTime: "12:00",
                                                      endTime: "13:35")])
        
        let denominatorWednesday = Day(title: .wednesday,
                                       lessons: [Lesson(title: "Схемотехника дискретных устройств",
                                                        teacher: "Спиридонов С. Б.",
                                                        room: "501ю",
                                                        type: .lecture,
                                                        startTime: "10:15",
                                                        endTime: "11:50"),
                                                 Lesson(title: "Базы данных",
                                                        teacher: "Ревунков Г. И.",
                                                        room: "501ю",
                                                        type: .lecture,
                                                        startTime: "12:00",
                                                        endTime: "13:35"),
                                                 Lesson(title: "Системное программирование",
                                                        teacher: "",
                                                        room: "306э/2",
                                                        type: .lab,
                                                        startTime: "13:50",
                                                        endTime: "15:25"),
                                                 Lesson(title: "Системное программирование",
                                                        teacher: "",
                                                        room: "306э/2",
                                                        type: .lab,
                                                        startTime: "15:40",
                                                        endTime: "17:15")])
        
        let numeratorThursday = Day(title: .thursday,
                                    lessons: [Lesson(title: "Физическое воспитание",
                                                     teacher: "",
                                                     room: "СК",
                                                     type: nil,
                                                     startTime: "12:00",
                                                     endTime: "13:35"),
                                              Lesson(title: "Электроника",
                                                     teacher: "Белодедов М. В.",
                                                     room: "501ю",
                                                     type: .lecture,
                                                     startTime: "13:50",
                                                     endTime: "15:25"),
                                              Lesson(title: "Системное программирование",
                                                     teacher: "Большаков С. А.",
                                                     room: "501ю",
                                                     type: .lecture,
                                                     startTime: "15:40",
                                                     endTime: "17:15"),
                                              Lesson(title: "Программирование в среде ХМL ",
                                                     teacher: "Гапанюк Ю. Е.",
                                                     room: "700",
                                                     type: .lab,
                                                     startTime: "17:25",
                                                     endTime: "19:00")])
        
        let denominatorThursday = Day(title: .thursday,
                                      lessons: [Lesson(title: "Физическое воспитание",
                                                       teacher: "",
                                                       room: "СК",
                                                       type: .lecture,
                                                       startTime: "12:00",
                                                       endTime: "13:35"),
                                                Lesson(title: "Электроника",
                                                       teacher: "Белодедов М. В.",
                                                       room: "501ю",
                                                       type: .lecture,
                                                       startTime: "13:50",
                                                       endTime: "15:25"),
                                                Lesson(title: "Системное программирование",
                                                       teacher: "Большаков С. А.",
                                                       room: "501ю",
                                                       type: .lecture,
                                                       startTime: "15:40",
                                                       endTime: "17:15"),
                                                Lesson(title: "Программирование в среде ХМL ",
                                                       teacher: "Гапанюк Ю. Е.",
                                                       room: "501ю",
                                                       type: .lecture,
                                                       startTime: "17:25",
                                                       endTime: "19:00")])
        
        let friday = Day(title: .friday,
                         lessons: [Lesson(title: "Физическое воспитание",
                                          teacher: "",
                                          room: "СК",
                                          type: nil,
                                          startTime: "13:50",
                                          endTime: "15:25"),
                                   Lesson(title: "Дискретная математика",
                                          teacher: "Безверхний Н. В.",
                                          room: "544л",
                                          type: .lecture,
                                          startTime: "15:40",
                                          endTime: "17:15"),
                                   Lesson(title: "Дискретная математика",
                                          teacher: "",
                                          room: "619л",
                                          type: .seminar,
                                          startTime: "17:25",
                                          endTime: "19:00"),
                                   Lesson(title: "Иностранный язык",
                                          teacher: "",
                                          room: "кафедра",
                                          type: .seminar,
                                          startTime: "19:10",
                                          endTime: "20:45")])
        
        
        let numeratorSaturday = Day(title: .saturday,
                                    lessons: [Lesson(title: "Электроника",
                                                    teacher: "Белодедов М. В.",
                                                    room: "700",
                                                    type: .lab,
                                                    startTime: "13:50",
                                                    endTime: "15:25"),
                                              Lesson(title: "Вычислительный практикум",
                                                    teacher: "",
                                                    room: "700",
                                                    type: .lab,
                                                    startTime: "15:40",
                                                    endTime: "17:15")])
        
        let schedule = Schedule(numeratorWeek: Week(kind: .numerator, days: [numeratorMonday,
                                                                             tuesday,
                                                                             numeratorWednesday,
                                                                             numeratorThursday,
                                                                             friday,
                                                                             numeratorSaturday]),
                                denominatorWeek: Week(kind: .denominator, days: [denominatorMonday,
                                                                                 tuesday,
                                                                                 denominatorWednesday,
                                                                                 denominatorThursday,
                                                                                 friday]))
        return schedule
    }
    
    func testRandomSchedule() -> Schedule {
        let schedule = Schedule()
        
        var daysTitles = [Day.Title.monday, Day.Title.tuesday, Day.Title.wednesday, Day.Title.thursday, Day.Title.friday, Day.Title.saturday]
        
        for i in 0...daysTitles.count-1 {
            
            let dayLessonsCount = arc4random_uniform(5) + 1
            var dayLessons: [Lesson] = []
            
            for _ in 0...dayLessonsCount {
                
                let lessonIndex = arc4random_uniform(3) + 1
                var lesson: Lesson?
                switch lessonIndex {
                case 1:
                    lesson = Lesson(title: "Теория вероятности",
                                    teacher: "Безверхний Н.В.",
                                    room: "230л",
                                    type: .lecture,
                                    startTime: "12:00",
                                    endTime: "13:35")
                case 2:
                    lesson = Lesson(title: "Электротехника",
                                    teacher: "Белодедов М.В.",
                                    room: "700",
                                    type: .lab,
                                    startTime: "13:50",
                                    endTime: "15:25")
                case 3:
                    lesson = Lesson(title: "Архитектура автоматизированных систем обработки информации и управления",
                                    teacher: "Шук В. П.",
                                    room: "501ю",
                                    type: .seminar,
                                    startTime: "10:15",
                                    endTime: "11:50")
                default:
                    break
                }
                
                dayLessons.append(lesson!)
            }
            
            let day = Day(title:daysTitles[i], lessons:dayLessons)
            schedule.numeratorWeek.days.append(day)
        }
        return schedule
    }
    
}
