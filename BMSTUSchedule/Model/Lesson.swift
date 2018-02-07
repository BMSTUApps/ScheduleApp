//
//  Lesson.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/*
 Lesson 🎓
 */
class Lesson: CustomStringConvertible {

    enum Kind: String {
        case lecture = "лекция"
        case seminar = "семинар"
        case lab     = "лаба"
    }
    
    static var dateFormatter: DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter
    }
    
    var title: String
    
    var teacher: String?
    var room: String?
    
    var kind: Kind?
    
    var startTime: String?
    var endTime: String?

    var description : String {
        return "Lesson(\"\(title)\")\n"
    }
    
    // MARK: Initialization
    
    init(title: String, teacher: String?, room: String?, kind: Kind?, startTime: String?, endTime: String?) {
        self.title = title
        self.teacher = teacher
        self.room = room
        self.kind = kind
        self.startTime = startTime
        self.endTime = endTime
    }
    
    convenience init(title: String, teacher: String?, room: String?) {
        self.init(title: title, teacher: teacher, room: room, kind: .lecture, startTime: "", endTime: "")
    }
    
    convenience init(title: String) {
        self.init(title: title, teacher: "", room: "")
    }
    
    convenience init() {
        self.init(title: "")
    }
}
