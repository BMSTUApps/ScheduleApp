//
//  RealmEvent.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEvent: Object {
    
    @objc dynamic var title: String = ""
    
    @objc dynamic var teacher: RealmTeacher? = nil
    @objc dynamic var location: String? = nil
    
    @objc dynamic var kind: String = ""
    
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
}

// MARK: - Model linking

extension RealmEvent {
    
    convenience init(_ model: Event) {
        self.init()
        
        self.title = model.title
        self.location = model.location
        self.kind = model.kind.rawValue
        self.startTime = model.startTime
        self.endTime = model.endTime
        
        if let teacher = model.teacher {
            self.teacher = RealmTeacher(teacher)
        }
    }
}

extension Event {
    
    convenience init(_ realmModel: RealmEvent) {
        self.init(title: realmModel.title, teacher: Teacher(realmModel.teacher), location: realmModel.location, kind: Kind(rawValue: realmModel.kind) ?? .other, startTime: realmModel.startTime, endTime: realmModel.endTime)
    }
}
