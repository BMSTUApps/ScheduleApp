//
//  ScheduleManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 20/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class Manager {
        
    static let calendarManager = CalendarManager()
    static let firebaseManager = FirebaseManager()
    
    // MARK: Test data
    
    func testSchedule() -> Schedule {
        
        let monday = Day(title: .monday,
                         lessons: [Lesson(title: "Физическое воспитание",
                                          teacher: "",
                                          room: "СК",
                                          type: nil,
                                          startTime: "13:50",
                                          endTime: "15:25"),
                                   Lesson(title: "Теория вероятностей и математическая статистика",
                                          teacher: "Безверхний Н. В.",
                                          room: "224л",
                                          type: .lecture,
                                          startTime: "15:40",
                                          endTime: "17:15"),
                                   Lesson(title: "Правоведение",
                                          teacher: "",
                                          room: "224л",
                                          type: .lecture,
                                          startTime: "17:25",
                                          endTime: "19:00")])
        
        let numeratorTuesday = Day(title: .thuesday,
                                   lessons: [Lesson(title: "Модели данных",
                                                    teacher: "Ковалева Н. А.",
                                                    room: "306э",
                                                    type: .lab,
                                                    startTime: "12:00",
                                                    endTime: "13:35"),
                                             Lesson(title: "Модели данных",
                                                    teacher: "Ковалева Н. А.",
                                                    room: "306э",
                                                    type: .lab,
                                                    startTime: "13:50",
                                                    endTime: "15:25"),
                                             Lesson(title: "Физика",
                                                    teacher: "",
                                                    room: "224л",
                                                    type: .lecture,
                                                    startTime: "15:40",
                                                    endTime: "17:15"),
                                             Lesson(title: "Электротехника",
                                                    teacher: "Белодедов М. В.",
                                                    room: "218л",
                                                    type: .lecture,
                                                    startTime: "17:25",
                                                    endTime: "19:00")])
        
        let denominatorTuesday = Day(title: .thuesday,
                                     lessons: [Lesson(title: "Физика",
                                                      teacher: "",
                                                      room: "224л",
                                                      type: .lecture,
                                                      startTime: "15:40",
                                                      endTime: "17:15"),
                                               Lesson(title: "Теория вероятностей и математическая статистика",
                                                      teacher: "Безверхний Н. В.",
                                                      room: "218л",
                                                      type: .lecture,
                                                      startTime: "17:25",
                                                      endTime: "19:00")])

        let numeratorWednesday = Day(title: .wednesday,
                                    lessons: [Lesson(title: "Электротехника",
                                                     teacher: "Белодедов М. В.",
                                                     room: "700",
                                                     type: .lab,
                                                     startTime: "10:15",
                                                     endTime: "11:50"),
                                              Lesson(title: "Модели данных",
                                                     teacher: "Ревунков Г. И.",
                                                     room: "501ю",
                                                     type: .lecture,
                                                     startTime: "12:00",
                                                     endTime: "13:35"),
                                              Lesson(title: "Базовые компоненты интернет-технологий",
                                                     teacher: "Гапанюк Ю. Е.",
                                                     room: "501ю",
                                                     type: .lecture,
                                                     startTime: "13:50",
                                                     endTime: "15:25"),
                                              Lesson(title: "Базовые компоненты интернет-технологий",
                                                     teacher: "Гапанюк Ю. Е.",
                                                     room: "306э",
                                                     type: .lab,
                                                     startTime: "15:40",
                                                     endTime: "17:15")])
        
        let denominatorWednesday = Day(title: .wednesday,
                                       lessons: [Lesson(title: "Физика",
                                                        teacher: "",
                                                        room: "дом физики",
                                                        type: .lab,
                                                        startTime: "8:30",
                                                        endTime: "10:05"),
                                                 Lesson(title: "Физика",
                                                        teacher: "",
                                                        room: "дом физики",
                                                        type: .lab,
                                                        startTime: "10:15",
                                                        endTime: "11:50"),
                                                 Lesson(title: "Модели данных",
                                                        teacher: "Ревунков Г. И.",
                                                        room: "501ю",
                                                        type: .lecture,
                                                        startTime: "12:00",
                                                        endTime: "13:35"),
                                                 Lesson(title: "Электротехника",
                                                        teacher: "Белодедов М. В.",
                                                        room: "501ю",
                                                        type: .lecture,
                                                        startTime: "13:50",
                                                        endTime: "15:25")])

        let thursday = Day(title: .thursday,
                           lessons: [Lesson(title: "Экология",
                                            teacher: "",
                                            room: "520",
                                            type: .seminar,
                                            startTime: "8:30",
                                            endTime: "10:05"),
                                     Lesson(title: "Архитектура автоматизированных систем обработки информации и управления",
                                            teacher: "Шук В. П.",
                                            room: "501ю",
                                            type: .lecture,
                                            startTime: "10:15", endTime: "11:50"),
                                     Lesson(title: "Физическое воспитание",
                                            teacher: "",
                                            room: "СК",
                                            type: nil,
                                            startTime: "12:00",
                                            endTime: "13:35"),
                                     Lesson(title: "Военная подготовка ",
                                            teacher: "",
                                            room: "ВК",
                                            type: .lecture,
                                            startTime: "13:50",
                                            endTime: "15:25")])
        
        let numeratorFriday = Day(title: .friday,
                                    lessons: [Lesson(title: "Теория вероятностей и математическая статистика",
                                                     teacher: "",
                                                     room: "830л",
                                                     type: .seminar,
                                                     startTime: "8:30",
                                                     endTime: "10:05"),
                                              Lesson(title: "Иностранный язык",
                                                     teacher: "",
                                                     room: "406л",
                                                     type: .seminar,
                                                     startTime: "10:15",
                                                     endTime: "11:50")])
        
        let denominatorFriday = Day(title: .friday,
                                  lessons: [Lesson(title: "Теория вероятностей и математическая статистика",
                                                   teacher: "",
                                                   room: "830л",
                                                   type: .seminar,
                                                   startTime: "8:30",
                                                   endTime: "10:05"),
                                            Lesson(title: "Иностранный язык",
                                                   teacher: "",
                                                   room: "406л",
                                                   type: .seminar,
                                                   startTime: "10:15",
                                                   endTime: "11:50"),
                                            Lesson(title: "Электротехника",
                                                    teacher: "Белодедов М. В.",
                                                    room: "831л",
                                                    type: .seminar,
                                                    startTime: "12:00",
                                                    endTime: "13:25")])
        
        let denominatorSaturday = Day(title: .saturday,
                                      lessons: [Lesson(title: "Правоведение",
                                                       teacher: "",
                                                       room: "523",
                                                       type: .seminar,
                                                       startTime: "13:50",
                                                       endTime: "15:25"),
                                                Lesson(title: "Физика",
                                                       teacher: "",
                                                       room: "520",
                                                       type: .seminar,
                                                       startTime: "15:40",
                                                       endTime: "17:15")])
        
        let schedule = Schedule(numeratorWeek: Week(kind: .numerator, days: [monday,
                                                                             numeratorTuesday,
                                                                             numeratorWednesday,
                                                                             thursday,
                                                                             numeratorFriday]),
                                denominatorWeek: Week(kind: .denominator, days: [monday,
                                                                                 denominatorTuesday,
                                                                                 denominatorWednesday,
                                                                                 thursday,
                                                                                 denominatorFriday,
                                                                                 denominatorSaturday]))
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
            }
            
            let day = Day(title:daysTitles[i], lessons:dayLessons)
            schedule.numeratorWeek.days.append(day)
        }
        return schedule
    }
    
}
