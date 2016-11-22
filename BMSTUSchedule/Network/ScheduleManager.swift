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
        
        scheduleRef.observe(.value, with: { snapshot in
            let schedule = Schedule()
        
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
            
                // Sort days
                var sortedDays: [Day] = []
                for dayTitle in Day.Title.allValues {
                    if let day = days.filter({$0.title == dayTitle}).first {
                        sortedDays.append(day)
                    }
                }
                days = sortedDays
                
                let weekType = (weekTypeSnap as! FIRDataSnapshot).key
                
                switch weekType {
                case "denominator":
                    schedule.numeratorWeek = days
                case "nominator":
                    schedule.denominatorWeek = days
                default:
                    break
                }

            }
            
            success(schedule)
        })
    }
    
    func addLesson(lesson: Lesson, group: Group, isNumerator: Bool, day: Day.Title) {
        
        var weekType = "denominator"
        if isNumerator {
            weekType = "nominator"
        }
        
        let lessonRef = FIRDatabase.database().reference(withPath: "schedules").child(group.name).child(weekType).child(day.rawValue).child(lesson.title)
        lessonRef.setValue(lesson.toAnyObject())
        
    }
    
}
