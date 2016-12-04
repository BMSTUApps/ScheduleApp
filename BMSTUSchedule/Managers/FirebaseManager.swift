//
//  FirebaseManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {

    let schedulesPath = "schedules"
    let groupsPath = "groups"
    
    func configure() {
        // Set firebase
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
    }
    
    // MARK: Get
    
    func getSchedule(group: Group, success: @escaping (Schedule) -> ()) {
        let scheduleRef = FIRDatabase.database().reference(withPath: schedulesPath).child(group.name)
        
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
    
    // MARK: Set
    
    func addGroup(group: Group) {
        
        let groupRef = FIRDatabase.database().reference(withPath: groupsPath).child(group.name)
        groupRef.setValue(group.toAnyObject())
        
    }
    
    func addLesson(lesson: Lesson, group: Group, weekKind: Week.Kind, dayTitle: Day.Title) {
        
        // Add group
        
        self.addGroup(group: group)
        
        // Add lesson
        
        let lessonRef = FIRDatabase.database().reference(withPath: schedulesPath).child(group.name).child(weekKind.rawValue).child(dayTitle.rawValue).child(lesson.generateKey())
        lessonRef.setValue(lesson.toAnyObject())
    }
    
    func addSchedule(schedule: Schedule, group: Group) {
        
        // Add group
        
        self.addGroup(group: group)
        
        // Add schedule
        
        let scheduleRef = FIRDatabase.database().reference(withPath: schedulesPath).child(group.name)
        
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
    
}
