//
//  Event.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/// Event 🎓
final class Event: Model {

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

    let id: ID
    
    let title: String
    
    let teacher: Teacher?
    
    let location: Location?
    let kind: Kind
    
    let date: Date
    let repeatIn: Int // weeks count to repeat
    let endDate: Date?
    
    let startTime: String
    let endTime: String

    override var description : String {
        return "Event(\"\(title)\")\n"
    }
    
    private enum Key: String {
        case id
        case title
        case teacherID = "teacher_id"
        case location
        case kind
        case date
        case repeatIn = "repeat_in"
        case endDate = "end_date"
        case startTime = "start_time"
        case endTime = "end_time"
    }
    
    // MARK: Initialization
    
    init?(_ json: JSON) {
        guard let id = json[Key.id.rawValue] as? ID,
            let title = json[Key.title.rawValue] as? String,
            let rawKind = json[Key.kind.rawValue] as? String, let kind = Kind(rawValue: rawKind),
            let rawDate = json[Key.date.rawValue] as? String, let date = Date(rawDate),
            let repeatIn = json[Key.repeatIn.rawValue] as? Int,
            let startTime = json[Key.startTime.rawValue] as? String,
            let endTime = json[Key.endTime.rawValue] as? String else {
            return nil
        }
        
        self.id = id
        
        self.title = title

        // TODO: Get teacher
        self.teacher = nil
        
        self.location = json[Key.location.rawValue] as? String
        self.kind = kind
        
        self.date = date
        self.repeatIn = repeatIn
        if let rawEndDate = json[Key.endDate.rawValue] as? String {
            self.endDate = Date(rawEndDate)
        } else {
            self.endDate = nil
        }
        
        self.startTime = startTime
        self.endTime = endTime
    }
    
    init(_ realm: RealmEvent) {
        self.id = realm.serverID
        self.title = realm.title
        
        if let realmTeacher = realm.teacher {
            self.teacher = Teacher(realmTeacher)
        } else {
            self.teacher = nil
        }
        
        self.location = realm.location
        self.kind = Event.Kind(rawValue: realm.kind) ?? .other
        self.date = realm.date
        self.repeatIn = realm.repeatIn
        self.endDate = realm.endDate
        self.startTime = realm.startTime
        self.endTime = realm.endTime
    }
}
