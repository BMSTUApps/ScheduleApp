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
