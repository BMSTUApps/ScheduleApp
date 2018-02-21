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

extension Day {
    
    convenience init(_ realmModel: RealmDay) {
        
        var lessons: [Lesson] = []
        
        for realmLesson in realmModel.lessons {
            let lesson = Lesson(realmLesson)
            lessons.append(lesson)
        }
        
        self.init(title: Title(rawValue: realmModel.title) ?? .monday, lessons: lessons, date: realmModel.date)
    }
}
