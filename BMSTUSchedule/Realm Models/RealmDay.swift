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
    
    let lessons = List<RealmLesson>()
}
