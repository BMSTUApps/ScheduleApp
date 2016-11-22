//
//  Lesson.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class Lesson: Base {

    enum LessonType: String {
        case lecture = "лекция"
        case seminar = "семинар"
        case lab = "лаба"
    }
    
    let key: String
    let ref: FIRDatabaseReference?
    
    var title: String
    
    var teacher: String?
    var room: String?
    
    var type: LessonType?
    
    var startTime: String?
    var endTime: String?
    
    init(title: String, teacher: String?, room: String?, type: LessonType?, startTime: String?, endTime: String?, key: String = "") {
        self.key = key
        self.ref = nil
        
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
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let snapshotValue = snapshot.value as? [String: AnyObject] {
            title = snapshotValue["title"] as! String
            teacher = snapshotValue["teacher"] as? String
            room = snapshotValue["room"] as? String
            type = LessonType(rawValue: snapshotValue["type"] as! String)
            startTime = snapshotValue["startTime"] as? String
            endTime = snapshotValue["endTime"] as? String
        } else {
            title = ""
            teacher = ""
            room = ""
            startTime = ""
            endTime = ""
        }
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "teacher": teacher,
            "room": room,
            "type": type?.rawValue,
            "startTime": startTime,
            "endTime": endTime
        ]
    }
    
    /*
    class func type(string: String) -> LessonType? {
        switch string {
        case "лекция":
            return .lecture
        case "семинар":
            return .seminar
        case "лаба":
            return .lab
        default:
            return nil
        }
    }
     */
    
}
