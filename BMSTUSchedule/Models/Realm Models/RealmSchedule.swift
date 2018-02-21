//
//  RealmSchedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSchedule: Object {
    
    @objc dynamic var group: RealmGroup?
    let weeks = List<RealmWeek>()
}

extension Schedule {
    
    convenience init(_ realmModel: RealmSchedule) {
        
        var weeks: [Week] = []
        
        for realmWeek in realmModel.weeks {
            let week = Week(realmWeek)
            weeks.append(week)
        }
        
        self.init(group: Group(realmModel.group), weeks: weeks)
    }
}
