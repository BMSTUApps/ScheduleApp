//
//  Date+Utils.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

fileprivate let dateLocale = Locale(identifier: "Ru_ru")

extension Date {

    // MARK: Formatting

    var weekday: String? {
        return string(format: "EEEE")
    }
    
    var weekdayIndex: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var weekIndex: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    init?(_ string: String, format: String = "dd.MM.yyyy") {
        
        let formatter = DateFormatter()
        formatter.locale = dateLocale
        formatter.dateFormat = format
        
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    func string(format: String) -> String? {
        
        let formatter = DateFormatter()
        formatter.locale = dateLocale
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
    
    // MARK: Week
    
    static var today: Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
    func over(weeksCount: Int) -> Date? {
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: weeksCount * 7, to: self)
        
        return date
    }
    
    // MARK: Helper
    
    private func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}
