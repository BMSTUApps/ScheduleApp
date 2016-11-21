//
//  Day.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class Day: Base {

    enum Title {
        case monday, thuesday, wednesday, thursday, friday, saturday
        func string() -> String {
            switch self {
            case .monday:
                return "понедельник"
            case .thuesday:
                return "вторник"
            case .wednesday:
                return "среда"
            case .thursday:
                return "четверг"
            case .friday:
                return "пятница"
            case .saturday:
                return "суббота"
            }
        }
    }
    
    var title: Title
    var lessons: [Lesson]
    
    init(title: Title, lessons: [Lesson], key: String = "") {
        self.title = title
        self.lessons = lessons
    }
    
    class func title(string: String) -> Title? {
        switch string {
        case "понедельник":
            return .monday
        case "вторник":
            return .thuesday
        case "среда":
            return .wednesday
        case "четверг":
            return .thursday
        case "пятница":
            return .friday
        case "суббота":
            return .saturday
        default:
            return nil
        }
    }
    
    override var description : String {
        return "Day(\"\(title.string())\")\n"
    }
    
}
