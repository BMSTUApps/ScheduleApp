//
//  Event.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/// Event 🎓
class Event: CustomStringConvertible {

    enum Kind: String {
        case lecture
        case seminar
        case lab
        case other
    }

    var title: String
    
    var teacher: Teacher?
    var location: String?
    
    var kind: Kind
    
    var startTime: String
    var endTime: String

    var description : String {
        return "Event(\"\(title)\")\n"
    }
    
    // MARK: Initialization
    
    init(title: String, teacher: Teacher?, location: String?, kind: Kind = .other, startTime: String, endTime: String) {
        self.title = title
        self.teacher = teacher
        self.location = location
        self.kind = kind
        self.startTime = startTime
        self.endTime = endTime
    }
    
    convenience init(title: String, teacher: Teacher?, location: String?) {
        self.init(title: title, teacher: teacher, location: location, kind: .other, startTime: "", endTime: "")
    }
    
    convenience init(title: String) {
        self.init(title: title, teacher: nil, location: nil)
    }
    
    convenience init() {
        self.init(title: "")
    }
}
