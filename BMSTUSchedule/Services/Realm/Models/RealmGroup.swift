//
//  RealmGroup.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroup: Object {

    @objc dynamic var serverID: String = ""
    
    @objc dynamic var department: String = ""
    @objc dynamic var number: Int = 0
    
    @objc dynamic var scheduleID: String = ""
}

// MARK: - Model linking

extension RealmGroup {
    
    convenience init(_ model: Group) {
        self.init()
        
        self.serverID = model.id
        self.department = model.department
        self.number = model.number
        self.scheduleID = model.scheduleID
    }
}
