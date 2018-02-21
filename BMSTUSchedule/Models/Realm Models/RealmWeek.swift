//
//  RealmWeek.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWeek: Object {

    @objc dynamic var number: Int = 0
    @objc dynamic var kind: String = ""
    
    let days = List<RealmDay>()
}

extension Week {
    
    convenience init(_ realmModel: RealmWeek) {
        
        var days: [Day] = []
        
        for realmDay in realmModel.days {
            let day = Day(realmDay)
            days.append(day)
        }
        
        self.init(number: realmModel.number, kind: Kind(rawValue: realmModel.kind) ?? .numerator, days: days)
    }
}
