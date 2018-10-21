//
//  Event.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/// Event 🎓
class Event: Model {

    enum Kind: String {
        case lecture
        case seminar
        case lab
        case other
        
        var localizedValue: String {
            return self.rawValue.localized
        }
    }
    
    typealias Location = String

    var title: String
    
    var teacher: Teacher?
    
    var location: Location?
    var kind: Kind
    
    var date: Date
    var repeatIn: Int // weeks count to repeat
    
    var startTime: String
    var endTime: String

    override var description : String {
        return "Event(\"\(title)\")\n"
    }
    
    // MARK: Initialization
    
    init(title: String, teacher: Teacher?, location: Location?, kind: Kind = .other, date: Date, repeatIn: Int = 0, startTime: String, endTime: String) {
        self.title = title
        self.teacher = teacher
        self.location = location
        self.kind = kind
        self.date = date
        self.repeatIn = repeatIn
        self.startTime = startTime
        self.endTime = endTime
    }
    
    convenience init(title: String, teacher: Teacher?, location: Location?) {
        self.init(title: title, teacher: teacher, location: location, kind: .other, date: Date(), repeatIn: 0, startTime: "", endTime: "")
    }
    
    convenience init(title: String) {
        self.init(title: title, teacher: nil, location: nil)
    }
    
    convenience override init() {
        self.init(title: "")
    }
}
