//
//  RealmSchedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSchedule: Object {

    @objc dynamic var serverID: String = ""
    @objc dynamic var isTemplate: Bool = false
    
    let events = List<RealmEvent>()
}

// MARK: - Model linking

extension RealmSchedule {
    
    convenience init(_ model: Schedule) {
        self.init()
        
        self.serverID = model.id
        self.isTemplate = model.isTemplate
        
        self.events.append(objectsIn: model.events.map({ event -> RealmEvent in
            return RealmEvent(event)
        }))
    }
}
