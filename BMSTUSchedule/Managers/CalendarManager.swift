//
//  CalendarManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class CalendarManager {
    
    // MARK: Keys

    private let startTermDateKey = "startTermDate"
    private let endTermDateKey   = "endTermDate"
    
    // MARK: Dates
    
    var startTermDate: Date? {
        get {
            // If date saved to defaults
            if let startDateString = UserDefaults.standard.string(forKey: startTermDateKey) {
                // If date is right
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "RU_ru")
                dateFormatter.dateFormat = "dd.MM.yyyy"
                if let date = dateFormatter.date(from: startDateString) {
                    return date
                }
            }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: startTermDateKey)
            self.startTermDate = newValue
        }
    }
    
    var endTermDate: Date? {
        get {
            // If date saved to defaults
            if let endDateString = UserDefaults.standard.string(forKey: endTermDateKey) {
                // If date is right
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "RU_ru")
                dateFormatter.dateFormat = "dd.MM.yyyy"
                if let date = dateFormatter.date(from: endDateString) {
                    return date
                }
            }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: endTermDateKey)
            self.startTermDate = newValue
        }
    }
    
    var currentDate: Date {
        get {
            let date = Date.init(timeIntervalSinceNow: 0)
            return date
        }
    }
    
    // MARK: Indexes
    
    let calendar = Calendar(identifier: .gregorian)
    
    private var startWeekIndex: Int {
        get {
            let date = self.startTermDate
            let weekIndex = calendar.component(.weekOfYear, from: date ?? Date.init(timeIntervalSinceNow: 0))
            
            return weekIndex
        }
    }
    private var endWeekIndex: Int {
        get {
            let date = self.endTermDate
            let weekIndex = calendar.component(.weekOfYear, from: date ?? Date.init(timeIntervalSinceNow: 0))
            
            return weekIndex
        }
    }
    private var currentWeekIndex: Int {
        get {
            let weekIndex = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
            return weekIndex
        }
    }
    
    // MARK: Create

    func createWeeksFromSchedule(schedule: Schedule, offset: Int, count: Int) -> [Week] {
        
        // Constants
        
        var currentDayIndexInWeek: Int {
            get {
                return self.dayIndexInWeek(date: self.currentDate)
            }
        }
        
        // Functions
        
        func switchWeekKind(weekKind: Week.Kind) -> Week.Kind {
            switch weekKind {
            case .numerator:
                return .denominator
            case .denominator:
                return .numerator
            }
        }
        
        // Set constants
        
        // 'Start' means start for calculation, NOT REAL START!!!
        let startWeekIndex = currentWeekIndex + offset
        let startWeekKind = weekKind(weekNumber: weekNumber(weekIndex: startWeekIndex))
        
        let startDate = self.dateWithDaysOffset(currentDate: self.currentDate, offset: 7*offset - currentDayIndexInWeek)
        
        // Calculate
        
        var weeks: [Week] = []
        
        var nowWeekKind = startWeekKind
        var nowWeekIndex = startWeekIndex
        var nowWeekDate = startDate
        
        for i in 1...count {
            
            let week = Week()
            
            week.number = weekNumber(weekIndex: nowWeekIndex)
            week.kind = nowWeekKind
            
            nowWeekDate = self.dateWithDaysOffset(currentDate: startDate, offset: i*7) // First date of week
            
            // Choose days for week kind
            var days: [Day] = []
            
            switch nowWeekKind {
            case .numerator:
                days = schedule.numeratorWeek.days
            case .denominator:
                days = schedule.denominatorWeek.days
            }
            
            // Copy days from schedule
            for day in days {
                let newDay = Day(day: day)
                week.days.append(newDay)
            }
            
            // Set date for days
            for day in week.days {
                day.date = self.dateWithDaysOffset(currentDate: nowWeekDate, offset: day.indexInWeek)
            }

            weeks.append(week)

            // Update constants
            nowWeekKind = switchWeekKind(weekKind: nowWeekKind)
            nowWeekIndex = nowWeekIndex + 1
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
    
    // Date
    
    // Get date with days offset
    // Ex: 12.11.2016 -(offset = -2)-> 10.11.2016
    func dateWithDaysOffset(currentDate: Date, offset: Int) -> Date {
        let calendar = Calendar.current
        let offsetDate = calendar.date(byAdding: .day, value: offset, to: currentDate)
        
        return offsetDate!
    }
    
    // Day
    
    func dayIndexInWeek(date: Date) -> Int {
        
        let calendar = Calendar.current
        var dayIndex = calendar.component(.weekday, from: date)
        
        if dayIndex == 0 {
            dayIndex = 6
        } else {
            dayIndex = dayIndex - 2
        }
        
        return dayIndex
    }
    
    // Week
    
    // Week number in study term from week index in year
    func weekNumber(weekIndex: Int) -> Int {
        return weekIndex - self.startWeekIndex + 1
    }
    
    // Week index in year term from week number in study term
    func weekIndex(weekNumber: Int) -> Int {
        return weekNumber + self.startWeekIndex - 1
    }
    
    func weekKind(weekNumber: Int) -> Week.Kind {
        if weekNumber % 2 == 0 {
            return .denominator
        } else {
            return .numerator
        }
    }
    
}
