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
        case lecture
        case seminar
        case lab
        case undefined
    }

    var title: String
    
    var teacher: String?
    var room: String?
    
    var kind: Kind
    
    var startTime: String
    var endTime: String

    var description : String {
        return "Lesson(\"\(title)\")\n"
    }
    
    // MARK: Initialization
    
    init(title: String, teacher: String?, room: String?, kind: Kind = .undefined, startTime: String, endTime: String) {
        self.title = title
        self.teacher = teacher
        self.room = room
        self.kind = kind
        self.startTime = startTime
        self.endTime = endTime
    }
    
    convenience init(title: String, teacher: String?, room: String?) {
        self.init(title: title, teacher: teacher, room: room, kind: .undefined, startTime: "", endTime: "")
    }
    
    convenience init(title: String) {
        self.init(title: title, teacher: nil, room: nil)
    }
    
    convenience init() {
        self.init(title: "")
    }
}
