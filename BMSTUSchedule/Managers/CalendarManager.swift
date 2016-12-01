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
    
    // MARK: Dates source

    func weeksFromSchedule(schedule: Schedule, offset: Int, count: Int) -> [Week] {
     
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
        
        let currentWeekNumber = currentWeekIndex - startWeekIndex + 1
        
        let startWeekNumber = currentWeekNumber + offset
        let startWeekKind = weekKind(weekNumber: startWeekNumber)
        
        var weeks: [Week] = []
        
        var nowWeekKind = startWeekKind
        var nowWeekNumber = startWeekNumber
        for _ in 0...count {
            
            let week = Week()
            week.number = nowWeekNumber
            week.kind = nowWeekKind
            
            switch nowWeekKind {
            case .numerator:
                week.days = schedule.numeratorWeek.days
            case .denominator:
                week.days = schedule.denominatorWeek.days
            }
            
            weeks.append(week)
            
            nowWeekKind = switchWeekKind(weekKind: nowWeekKind)
            nowWeekNumber = nowWeekNumber + 1
        }
        
        return weeks
    }
    
}
