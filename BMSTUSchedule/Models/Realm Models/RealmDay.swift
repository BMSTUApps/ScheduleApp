//
//  RealmDay.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDay: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    
    let events = List<RealmEvent>()
}

// MARK: - Model linking

extension RealmDay {
    
    convenience init(_ model: Day) {
        self.init()
        
        self.title = model.title.rawValue
        self.date = model.date
        
        var realmEvents: [RealmEvent] = []
        
        for event in model.events {
            let realmEvent = RealmEvent(event)
            realmEvents.append(realmEvent)
        }
        
        self.events.append(objectsIn: realmEvents)
    }
}

extension Day {
    
    convenience init(_ realmModel: RealmDay) {
        
        var events: [Event] = []
        
        for realmEvent in realmModel.events {
            let event = Event(realmEvent)
            events.append(event)
        }
        
        self.init(title: Title(rawValue: realmModel.title) ?? .monday, events: events, date: realmModel.date)
    }
}
