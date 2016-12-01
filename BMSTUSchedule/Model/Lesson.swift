//
//  Lesson.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class Lesson: Base, Equatable {

    enum Kind: String {
        case lecture = "лекция"
        case seminar = "семинар"
        case lab = "лаба"
    }
    
    let key: String
    let ref: FIRDatabaseReference?
    
    var title: String
    
    var teacher: String?
    var room: String?
    
    var type: Kind?
    
    var startTime: String?
    var endTime: String?
    
    override var description : String {
        return "Lesson(\"\(title)\")\n"
    }
    
    func generateKey() -> String {
        let key = "\(self.startTime ?? "") - \(self.endTime ?? "") \(self.title)"
        return key
    }
    
    // MARK: Initialization
    
    init(title: String, teacher: String?, room: String?, type: Kind?, startTime: String?, endTime: String?, key: String = "") {
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
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let snapshotValue = snapshot.value as? [String: AnyObject] {
            title = snapshotValue["title"] as! String
            teacher = snapshotValue["teacher"] as? String
            room = snapshotValue["room"] as? String
            if let typeString = snapshotValue["type"] {
                type = Kind(rawValue: typeString as! String)
            } else {
                type = nil
            }
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
    
    // MARK: Equatable
    
    static func ==(lhs: Lesson, rhs: Lesson) -> Bool {
        
        return lhs.key == rhs.key
    }
    
    // MARK: Export
    
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
    
}
