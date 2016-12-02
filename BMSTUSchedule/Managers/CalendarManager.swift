//
//  CalendarManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class CalendarManager {

    // MARK: Constants
    
    // Only for debug!!!
    // In release it will be stored in FireBase
    var startWeekIndex: Int {
        get {
            let dateString = "01.09.2016"
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "US_en")
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = dateFormatter.date(from: dateString)
            
            let calendar = Calendar.current
            let weekIndex = calendar.component(.weekOfYear, from: date ?? Date.init(timeIntervalSinceNow: 0))
            
            return weekIndex
        }
    }
    var currentWeekIndex: Int {
        get {
            let calendar = Calendar.current
            let weekIndex = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
            return weekIndex
        }
    }
    
    var currentDate: Date {
        get {
            let date = Date.init(timeIntervalSinceNow: 0)
            return date
        }
    }
    
    // MARK: Create
    
    func createWeeksFromSchedule(schedule: Schedule, offset: Int, count: Int) -> [Week] {
     
        // BUG: Wrong counting week index with offset and count 
        // Need to fix it!!!
        
        // Constants
        
        var currentDayOfWeekIndex: Int {
            get {
                let calendar = Calendar.current
                var dayIndex = calendar.component(.weekday, from: self.currentDate)
                
                if dayIndex == 0 {
                    dayIndex = 6
                } else {
                    dayIndex = dayIndex - 2
                }
                
                return dayIndex
            }
        }
        
        // Functions
        
        func weekKind(weekNumber: Int) -> Week.Kind {
            if weekNumber % 2 == 0 {
                return .denominator
            } else {
                return .numerator
            }
        }
        
        func switchWeekKind(weekKind: Week.Kind) -> Week.Kind {
            switch weekKind {
            case .numerator:
                return .denominator
            case .denominator:
                return .numerator
            }
        }
        
        func tomorrow(today: Date) -> Date? {
            return self.dateWithDaysOffset(currentDate: today, offset: 1)
        }
        
        // Setting constants
        
        let currentWeekNumber = currentWeekIndex - startWeekIndex + 1
        
        let startWeekNumber = currentWeekNumber + offset
        let startWeekKind = weekKind(weekNumber: startWeekNumber)
        
        let daysOffset = offset * 7 - currentDayOfWeekIndex
        let startDayDate = self.dateWithDaysOffset(currentDate: self.currentDate, offset: daysOffset) ?? self.currentDate
        
        // Calculating
        
        var weeks: [Week] = []
        
        var nowWeekKind = startWeekKind
        var nowWeekNumber = startWeekNumber
        
        for _ in 1...count {
            let week = Week()
            week.number = nowWeekNumber
            week.kind = nowWeekKind
            
            // Choosing days for week kind
            switch nowWeekKind {
            case .numerator:
                week.days = schedule.numeratorWeek.days
            case .denominator:
                week.days = schedule.denominatorWeek.days
            }

            // Setting date for days
            for day in week.days {
                let weekCount = nowWeekNumber - currentWeekNumber
                let offset = 7 * weekCount + day.indexInWeek
                
                if let date = self.dateWithDaysOffset(currentDate: startDayDate, offset: offset) {
                    day.date = date
                }
            }
            
            weeks.append(week)
            
            // Update constants
            nowWeekKind = switchWeekKind(weekKind: nowWeekKind)
            nowWeekNumber = nowWeekNumber + 1
        }
        
        return weeks
    }
    
    // MARK: Calculate
    
    func calculateBreakTime(lastLesson: Lesson, lesson: Lesson) -> Int? {
        if let endTime = lastLesson.endTime, let startTime = lesson.startTime {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            let startBreakDate = dateFormatter.date(from: endTime) ?? Date()
            let endBreakDate = dateFormatter.date(from: startTime) ?? Date()

            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute], from: startBreakDate, to: endBreakDate)
            
            return components.minute
        } else {
            return nil
        }
    }
    
    // MARK: Utility
    
    // Get date with days offset
    //
    // Example: 12.11.2016 -(offset = -2)-> 10.11.2016
    
    func dateWithDaysOffset(currentDate: Date, offset: Int) -> Date? {
        let calendar = Calendar.current
        let offsetDate = calendar.date(byAdding: .day, value: offset, to: currentDate)
        
        return offsetDate ?? nil
    }
        
}
