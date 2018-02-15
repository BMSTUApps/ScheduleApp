//
//  DayViewModel.swift
//  BMSTUSchedule
//
//  Created by Arthur K1ng on 15/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class DayViewModel {

    let title: String
    let lessons: [LessonViewModel]
    
    init(_ day: Day) {
        
        self.title = day.title.rawValue
        
        var lessonsViewModels: [LessonViewModel] = []
        for lesson in day.lessons {
            let lessonViewModel = LessonViewModel(lesson)
            lessonsViewModels.append(lessonViewModel)
        }
        self.lessons = lessonsViewModels
    }
}
