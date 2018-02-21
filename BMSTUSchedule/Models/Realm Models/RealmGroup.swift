//
//  RealmGroup.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroup: Object {

    @objc dynamic var name: String = ""
    
    @objc dynamic var department: String = ""
    @objc dynamic var number: Int = 0
    @objc dynamic var course: Int = 0
}

// MARK: - Model linking

extension RealmGroup {
    
    convenience init(_ model: Group) {
        self.init()
        
        self.name = model.name
        self.department = model.department
        self.number = model.number
        self.course = model.course
    }
}

extension Group {
    
    convenience init(_ realmModel: RealmGroup?) {
        self.init(name: realmModel?.name ?? "")
    }
}
