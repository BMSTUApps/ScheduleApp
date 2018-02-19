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
