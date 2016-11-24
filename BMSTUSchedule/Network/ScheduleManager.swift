//
//  ScheduleManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 20/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class ScheduleManager {
    
    static let sharedManager = ScheduleManager()

    func getSchedule(group: Group, success: @escaping (Schedule) -> ()) {
        let scheduleRef = FIRDatabase.database().reference(withPath: "schedules").child(group.name)

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
                        lessons.append(lesson)
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
                
                let weekType = (weekTypeSnap as! FIRDataSnapshot).key
                
                switch weekType {
                case "denominator":
                    schedule.numeratorWeek = days
                case "numerator":
                    schedule.denominatorWeek = days
                default:
                    break
                }
            }
            success(schedule)
        })
    }
    
    // MARK: Lesson
    
    func addLesson(lesson: Lesson, group: Group, isNumerator: Bool, day: Day.Title) {
        
        var weekType = "denominator"
        if isNumerator {
            weekType = "numerator"
        }
        
        let lessonRef = FIRDatabase.database().reference(withPath: "schedules").child(group.name).child(weekType).child(day.rawValue).child(lesson.title)
        lessonRef.setValue(lesson.toAnyObject())
        
    }
    
    // MARK: Schedule
    
    func addSchedule(schedule: Schedule, group: Group) {
        let scheduleRef = FIRDatabase.database().reference(withPath: "schedules").child(group.name)
        
        // Set numerator week
        let numeratorWeekRef = scheduleRef.child("numerator")
        for day in schedule.numeratorWeek {
            let dayRef = numeratorWeekRef.child(day.title.rawValue)
            for lesson in day.lessons {
                let lessonRef = dayRef.child(lesson.title)
                lessonRef.setValue(lesson.toAnyObject())
            }
        }
        
        // Set denominator week
        let denominatorWeekRef = scheduleRef.child("denominator")
        for day in schedule.denominatorWeek {
            let dayRef = denominatorWeekRef.child(day.title.rawValue)
            for lesson in day.lessons {
                let lessonRef = dayRef.child(lesson.title)
                lessonRef.setValue(lesson.toAnyObject())
            }
        }
    }
    
    // MARK: Test data
    
    func testSchedule() -> Schedule {
        
        let monday = Day(title: .monday,
                         lessons: [Lesson(title: "Физическое воспитание", teacher: "", room: "СК", type: nil, startTime: "13:50", endTime: "15:25"),
                                   Lesson(title: "Теория вероятностей и математическая статистика", teacher: "Безверхний Н. В.", room: "224л", type: .lecture, startTime: "15:40", endTime: "17:15"),
                                   Lesson(title: "Правоведение", teacher: "", room: "224л", type: .lecture, startTime: "17:25", endTime: "19:00")])
        
        let numeratorTuesday = Day(title: .thuesday,
                                   lessons: [Lesson(title: "Модели данных", teacher: "Ковалева Н. А.", room: "306э", type: .lab, startTime: "12:00", endTime: "13:35"),
                                             Lesson(title: "Модели данных", teacher: "Ковалева Н. А.", room: "306э", type: .lab, startTime: "13:50", endTime: "15:25"),
                                             Lesson(title: "Физика", teacher: "", room: "224л", type: .lecture, startTime: "15:40", endTime: "17:15"),
                                             Lesson(title: "Электротехника", teacher: "Белодедов М. В.", room: "218л", type: .lecture, startTime: "17:25", endTime: "19:00")])
        
        let denominatorTuesday = Day(title: .thuesday,
                                     lessons: [Lesson(title: "Физика", teacher: "", room: "224л", type: .lecture, startTime: "15:40", endTime: "17:15"),
                                               Lesson(title: "Теория вероятностей и математическая статистика", teacher: "Безверхний Н. В.", room: "218л", type: .lecture, startTime: "17:25", endTime: "19:00")])
        
        let numeratorWednesday = Day(title: .wednesday,
                                     lessons: [Lesson(title: "Электротехника", teacher: "Белодедов М. В.", room: "700", type: .lab, startTime: "10:15", endTime: "11:50"),
                                               Lesson(title: "Модели данных", teacher: "Ревунков Г. И.", room: "501ю", type: .lecture, startTime: "12:00", endTime: "13:35"),
                                               Lesson(title: "Базовые компоненты интернет-технологий", teacher: "Гапанюк Ю. Е.", room: "501ю", type: .lecture, startTime: "13:50", endTime: "15:25"),
                                               Lesson(title: "Базовые компоненты интернет-технологий", teacher: "Гапанюк Ю. Е.", room: "306э", type: .lab, startTime: "15:40", endTime: "17:15")])
        
        let denominatorWednesday = Day(title: .wednesday,
                                       lessons: [Lesson(title: "Физика", teacher: "", room: "дом физики", type: .lab, startTime: "8:30", endTime: "10:05"),
                                                 Lesson(title: "Физика", teacher: "", room: "дом физики", type: .lab, startTime: "10:15", endTime: "11:50"),
                                                 Lesson(title: "Модели данных", teacher: "Ревунков Г. И.", room: "501ю", type: .lecture, startTime: "12:00", endTime: "13:35"),
                                                 Lesson(title: "Электротехника", teacher: "Белодедов М. В.", room: "501ю", type: .lecture, startTime: "13:50", endTime: "15:25")])
        
        let thursday = Day(title: .thursday,
                           lessons: [Lesson(title: "Экология", teacher: "", room: "520", type: .seminar, startTime: "8:30", endTime: "10:05"),
                                     Lesson(title: "Архитектура автоматизированных систем обработки информации и управления", teacher: "Шук В. П.", room: "501ю", type: .lecture, startTime: "10:15", endTime: "11:50"),
                                     Lesson(title: "Физическое воспитание", teacher: "", room: "СК", type: nil, startTime: "12:00", endTime: "13:35"),
                                     Lesson(title: "Военная подготовка ", teacher: "", room: "ВК", type: .lecture, startTime: "13:50", endTime: "15:25")])
        
        let numeratorFriday = Day(title: .friday,
                                  lessons: [Lesson(title: "Теория вероятностей и математическая статистика", teacher: "", room: "830л", type: .seminar, startTime: "8:30", endTime: "10:05"),
                                            Lesson(title: "Иностранный язык", teacher: "", room: "406л", type: .seminar, startTime: "10:15", endTime: "11:50")])
        
        let denominatorFriday = Day(title: .friday,
                                    lessons: [Lesson(title: "Теория вероятностей и математическая статистика", teacher: "", room: "830л", type: .seminar, startTime: "8:30", endTime: "10:05"),
                                              Lesson(title: "Иностранный язык", teacher: "", room: "406л", type: .seminar, startTime: "10:15", endTime: "11:50"),
                                              Lesson(title: "Электротехника", teacher: "Белодедов М. В.", room: "831л", type: .seminar, startTime: "12:00", endTime: "13:25")])
        
        let denominatorSaturday = Day(title: .saturday,
                                      lessons: [Lesson(title: "Правоведение", teacher: "", room: "523", type: .seminar, startTime: "13:50", endTime: "15:25"),
                                                Lesson(title: "Физика", teacher: "", room: "520", type: .seminar, startTime: "15:40", endTime: "17:15")])
        
        let schedule = Schedule(numeratorWeek: [monday, numeratorTuesday, numeratorWednesday, thursday, numeratorFriday],
                                denominatorWeek: [monday, denominatorTuesday, denominatorWednesday, thursday, denominatorFriday, denominatorSaturday])
        return schedule
    }
    
    func randomSchedule() -> Schedule {
        let schedule = Schedule()
        
        var daysTitles = [Day.Title.monday, Day.Title.thuesday, Day.Title.wednesday, Day.Title.thursday, Day.Title.friday, Day.Title.saturday]
        
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
                
                // Add to firebase
                ScheduleManager.sharedManager.addLesson(lesson: lesson!, group: Group(name: "ИУ5-33"), isNumerator: false, day: daysTitles[i])
                
            }
            
            let day = Day(title:daysTitles[i], lessons:dayLessons)
            schedule.numeratorWeek.append(day)
        }
        return schedule
    }
    
}
