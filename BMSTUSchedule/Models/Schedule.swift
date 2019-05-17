//
//  Schedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

/// Schedule 🗓
class Schedule: Model {

    let id: ID
    let isTemplate: Bool
    let events: [Event]
    
    private enum Key: String {
        case id
        case isTemplate = "is_template"
        case events
    }
    
    // MARK: Initialization
    
    init?(_ json: JSON) {
        guard let id = json[Key.id.rawValue] as? ID,
            let isTemplate = json[Key.isTemplate.rawValue] as? Bool,
            let rawEvents = json[Key.events.rawValue] as? [JSON] else {
            return nil
        }

        self.id = id
        self.isTemplate = isTemplate
        self.events = rawEvents.compactMap { json -> Event? in
            return Event(json)
        }
    }
    
    init(_ realm: RealmSchedule) {
        self.id = realm.serverID
        self.isTemplate = realm.isTemplate
        self.events = realm.events.compactMap({ realmEvent -> Event? in
            return Event(realmEvent)
        })
    }
}
