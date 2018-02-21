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

// MARK: - Model linking

extension RealmDay {
    
    convenience init(_ model: Day) {
        self.init()
        
        self.title = model.title.rawValue
        self.date = model.date
        
        var realmLessons: [RealmLesson] = []
        
        for lesson in model.lessons {
            let realmLesson = RealmLesson(lesson)
            realmLessons.append(realmLesson)
        }
        
        self.lessons.append(objectsIn: realmLessons)
    }
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
