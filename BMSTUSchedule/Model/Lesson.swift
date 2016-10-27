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
    
    public override init() {
        self.title = ""
    }
    
    public convenience init(title: String) {
        self.init(title: title, teacher: "", room: "", type: LessonType.lecture)
    }
    
    public convenience init(title: String, teacher: String?, room: String?) {
        self.init(title: title, teacher: teacher, room: room, type: LessonType.lecture)
    }
    
    public init(title: String, teacher: String?, room: String?, type: LessonType?) {
        self.title = title
        self.teacher = teacher
        self.room = room
        self.type = type
    }
    
    override var description : String {
        return "Lesson(\"\(title)\")\n"
    }
    
}
