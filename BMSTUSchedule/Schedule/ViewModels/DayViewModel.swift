//
//  DayViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 15/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class DayViewModel {

    let title: String
    let lessons: [LessonViewModel]
    
    init(_ day: Day) {
        
        self.title = day.title.rawValue
        
        var lessonsViewModels: [LessonViewModel] = []
        for (index, lesson) in day.lessons.enumerated() {
            
            var brakeText = ""
            
            let isLastLessonExist = day.lessons.indices.contains(index-1)
            if isLastLessonExist {
                brakeText = AppManager.shared.calculateBrake(lesson1: day.lessons[index-1], lesson2: lesson) ?? ""
            }
            
            let lessonViewModel = LessonViewModel(lesson, brakeText: brakeText)
            lessonsViewModels.append(lessonViewModel)
        }
        self.lessons = lessonsViewModels
    }
}
