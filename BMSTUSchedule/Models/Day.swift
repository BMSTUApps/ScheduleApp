//
//  Day.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/*
 Day 🌞
 */
class Day: CustomStringConvertible {

    enum Title: String {
        case monday    = "monday"
        case tuesday   = "tuesday"
        case wednesday = "wednesday"
        case thursday  = "thursday"
        case friday    = "friday"
        case saturday  = "saturday"
        
        static let allValues = [monday, tuesday, wednesday, thursday, friday, saturday]
    }
    
    var title: Title
    var date: Date
    
    var lessons: [Lesson]
    
    var indexInWeek: Int {
        get {
            switch title {
            case .monday:
                return 0
            case .tuesday:
                return 1
            case .wednesday:
                return 2
            case .thursday:
                return 3
            case .friday:
                return 4
            case .saturday:
                return 5
            }
        }
    }
    
    var description : String {
        return "Day(\(date) - \"\(title)\")\n"
    }
    
    // MARK: Initialization
    
    init(title: Title, lessons: [Lesson], date: Date) {
        self.title = title
        self.date = date
        self.lessons = lessons
    }
}
