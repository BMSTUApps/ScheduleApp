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

    @objc dynamic var serverID: Int = 0
    
    @objc dynamic var title: String = ""
    
    @objc dynamic var teacher: RealmTeacher? = nil
    
    @objc dynamic var location: String? = nil
    @objc dynamic var kind: String = ""
    
    @objc dynamic var date: Date = Date()
    @objc dynamic var repeatIn: Int = 0
    @objc dynamic var endDate: Date? = nil

    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
}

// MARK: - Model linking

extension RealmEvent {
    
    convenience init(_ model: Event) {
        self.init()
        
        self.serverID = model.id
        self.title = model.title
        self.location = model.location
        self.kind = model.kind.rawValue
        self.date = model.date
        self.repeatIn = model.repeatIn
        self.endDate = model.endDate
        self.startTime = model.startTime
        self.endTime = model.endTime
        
        if let teacher = model.teacher {
            self.teacher = RealmTeacher(teacher)
        }
    }
}
