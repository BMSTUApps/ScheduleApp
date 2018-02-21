//
//  RealmLesson.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLesson: Object {
    
    @objc dynamic var title: String = ""
    
    @objc dynamic var teacher: String? = nil
    @objc dynamic var room: String? = nil
    
    @objc dynamic var kind: String = ""
    
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
}

extension Lesson {
    
    convenience init(_ realmModel: RealmLesson) {
        self.init(title: realmModel.title, teacher: realmModel.teacher, room: realmModel.room, kind: Kind(rawValue: realmModel.kind) ?? .undefined, startTime: realmModel.startTime, endTime: realmModel.endTime)
    }
}
