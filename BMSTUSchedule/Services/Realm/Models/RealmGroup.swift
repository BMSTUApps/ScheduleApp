//
//  RealmGroup.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroup: Object {

    @objc dynamic var serverID: Int = 0
    
    @objc dynamic var department: String = ""
    @objc dynamic var number: String = ""
    
    @objc dynamic var scheduleID: Int = 0
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
