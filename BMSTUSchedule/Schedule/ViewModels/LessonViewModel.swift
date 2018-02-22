//
//  LessonViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 15/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class LessonViewModel {
    
    let brakeText: String
    let kindText: String
    
    let titleText: String
    
    let teacherText: String
    let roomText: String

    let startTime: String
    let endTime: String
    
    init(_ lesson: Lesson, brakeText: String = "") {
        
        self.brakeText = brakeText
        
        if lesson.kind == .other {
            self.kindText = ""
        } else {
            self.kindText = lesson.kind.rawValue
        }
        
        self.titleText = lesson.title
        
        self.teacherText = lesson.teacher ?? ""
        self.roomText = lesson.room ?? ""
        
        self.startTime = lesson.startTime
        self.endTime = lesson.endTime
    }
}
