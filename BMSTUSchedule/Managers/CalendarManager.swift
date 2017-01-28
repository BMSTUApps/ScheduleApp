//
//  CalendarManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class CalendarManager {
    
    let calendar = Calendar(identifier: .gregorian)
    
    // MARK: Keys

    private let startTermDateKey = "startTermDate"
    private let endTermDateKey   = "endTermDate"
    
    private let localeIdentifier = "RU_ru"
    private let dateFormat = "dd.MM.yyyy"
    
    // MARK: Dates
    
    // Dates are loaded from NSUserDefaults
    
    var startTermDate: Date? {
        get {
            // If date saved to defaults
            if let startDateString = UserDefaults.standard.string(forKey: startTermDateKey) {
                
                // If date is right
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: localeIdentifier)
                dateFormatter.dateFormat = dateFormat
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
                dateFormatter.locale = Locale(identifier: localeIdentifier)
                dateFormatter.dateFormat = dateFormat
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
    
    // MARK: Indices
    
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
        var startWeekIndex = currentWeekIndex + offset
        var startWeekKind = weekKind(weekNumber: weekNumber(weekIndex: startWeekIndex))
        
        var startDate = self.dateWithDaysOffset(currentDate: self.currentDate, offset: 7*offset - currentDayIndexInWeek)
        
        // if startTermDate & endTermDate loaded
        if let startTermDate = self.startTermDate, let _ = self.endTermDate {
            // if startDate < startTermDate
            if startDate.compare(startTermDate) == .orderedAscending {
                startWeekIndex = self.weekIndex(weekNumber: 1)
                startWeekKind = weekKind(weekNumber: 1)
                startDate = startTermDate
            }
        } else {
            return []
        }
        
        // Calculate
        
        var weeks: [Week] = []
        
        var nowWeekKind = startWeekKind
        var nowWeekIndex = startWeekIndex
        var nowWeekDate = startDate
        
        for i in 1...count {
            
            // if nowWeekDate > endTermDate
            if nowWeekDate.compare(self.endTermDate!) == .orderedDescending {
                break
            }
            
            let week = Week()
            
            week.number = weekNumber(weekIndex: nowWeekIndex)
            week.kind = nowWeekKind
            
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
                let date = self.dateWithDaysOffset(currentDate: nowWeekDate, offset: day.indexInWeek)
                day.date = date
            }

            weeks.append(week)

            // Update constants
            nowWeekDate = self.dateWithDaysOffset(currentDate: startDate, offset: i*7) // First date of week
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
