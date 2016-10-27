//
//  Lesson.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

class Lesson: Base {

    enum LessonType {
        case lecture
        case seminar
        case lab
        case consultation
    }
    
    var title: String
    
    var teacher: String?
    var room: String?
    
    var type: LessonType?
    
    var startTime: String?
    var endTime: String?
    
    init(title: String, teacher: String?, room: String?, type: LessonType?, startTime: String?, endTime: String?) {
        self.title = title
        self.teacher = teacher
        self.room = room
        self.type = type
        self.startTime = startTime
        self.endTime = endTime
    }
    
    convenience init(title: String, teacher: String?, room: String?) {
        self.init(title: title, teacher: teacher, room: room, type: .lecture, startTime: "", endTime: "")
    }
    
    convenience init(title: String) {
        self.init(title: title, teacher: "", room: "")
    }
    
    override var description : String {
        return "Lesson(\"\(title)\")\n"
    }
    
}
