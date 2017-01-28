//
//  Day.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase

class Day: CustomStringConvertible {

    enum Title: String {
        case monday    = "понедельник"
        case tuesday   = "вторник"
        case wednesday = "среда"
        case thursday  = "четверг"
        case friday    = "пятница"
        case saturday  = "суббота"
        
        static let allValues = [monday, tuesday, wednesday, thursday, friday, saturday]
    }
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.dateFormat = "dd MMMM"
        
        return dateFormatter
    }
    
    var description : String {
        return "Day(\(date) - \"\(title)\")\n"
    }
    
    var title: Title
    var lessons: [Lesson]
    
    var date: Date = Date()
    
    var dateString: String? {
        get {
            let dateString = Day.dateFormatter.string(from: self.date)
            return dateString
        }
    }
    
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
    
    // MARK: Initialization
    
    init(title: Title, lessons: [Lesson], key: String = "") {
        self.title = title
        self.lessons = lessons
    }
    
    convenience init(day: Day) {
        self.init(title: day.title, lessons: day.lessons)
    }
    
}
