//
//  Day.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class Day: Base {

    enum Title: String {
        case monday    = "понедельник"
        case thuesday  = "вторник"
        case wednesday = "среда"
        case thursday  = "четверг"
        case friday    = "пятница"
        case saturday  = "суббота"
    }
    
    var title: Title
    var lessons: [Lesson]
    
    init(title: Title, lessons: [Lesson], key: String = "") {
        self.title = title
        self.lessons = lessons
    }
    
    /*
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
     */
    
    override var description : String {
        return "Day(\"\(title)\")\n"
    }
    
}
