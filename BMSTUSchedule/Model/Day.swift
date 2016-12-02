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
        
        static let allValues = [monday, thuesday, wednesday, thursday, friday, saturday]
    }
    
    override var description : String {
        return "Day(\"\(title)\")\n"
    }
    
    var title: Title
    var lessons: [Lesson]
    
    var date: Date = Date()
    
    var dateString: String? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "RU_ru")
            dateFormatter.dateFormat = "dd MMMM"
            
            let dateString = dateFormatter.string(from: self.date)
            return dateString
        }
    }
    
    // MARK: Initialization
    
    init(title: Title, lessons: [Lesson], key: String = "") {
        self.title = title
        self.lessons = lessons
    }
    
}
