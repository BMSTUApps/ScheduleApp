//
//  LessonCalendarCellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonCalendarCellViewModel: CellViewModel {

    var currentLesson: Lesson
    var displayedLessons: [Lesson]
    
    init(currentLesson: Lesson, displayedLessons: [Lesson]) {
        
        self.currentLesson = currentLesson
        self.displayedLessons = displayedLessons
        
        super.init(identifier: String(describing: LessonCalendarCell.self))
    }
}
