//
//  Lesson.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase

/*
 Lesson 🎓
 */
class Lesson: CustomStringConvertible, Equatable {

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
    
    let key: String
    let ref: FIRDatabaseReference?
    
    var title: String
    
    var teacher: String?
    var room: String?
    
    var kind: Kind?
    
    var startTime: String?
    var endTime: String?

    var description : String {
        return "Lesson(\"\(title)\")\n"
    }
    
    // MARK: Firebase
    
    func generateKey() -> String {
        let key = "\(self.startTime ?? "") - \(self.endTime ?? "") \(self.title)"
        return key
    }
    
    // MARK: Initialization
    
    init(title: String, teacher: String?, room: String?, kind: Kind?, startTime: String?, endTime: String?, key: String = "") {
        self.key = key
        self.ref = nil
        
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
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let snapshotValue = snapshot.value as? [String: AnyObject] {
            title = snapshotValue["title"] as! String
            teacher = snapshotValue["teacher"] as? String
            room = snapshotValue["room"] as? String
            if let kindString = snapshotValue["kind"] {
                kind = Kind(rawValue: kindString as! String)
            } else {
                kind = nil
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
            "kind": kind?.rawValue,
            "startTime": startTime,
            "endTime": endTime
        ]
    }
}
