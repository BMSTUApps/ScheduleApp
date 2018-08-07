//
//  LessonViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonViewModel {
    
    var count: Int {
        return viewModels.count
    }
    
    private var viewModels: [CellViewModel] = []
    private let lesson: Lesson
    private let displayedLessons: [Lesson]?

    init(_ lesson: Lesson, displayedLessons: [Lesson]? = nil) {
        
        self.lesson = lesson
        self.displayedLessons = displayedLessons
        
        fillTitleViewModel()
        fillDescriptionViewModel()
        fillLocationViewModel()
        fillTeacherViewModel()
        fillCalendarViewModel()
    }
    
    func viewModel(for indexPath: IndexPath) -> CellViewModel? {
        
        if indexPath.row < viewModels.count {
            return viewModels[indexPath.row]
        }
        
        return nil
    }
    
    private func fillTitleViewModel() {
        
        let titleViewModel = LessonTitleCellViewModel(title: lesson.title, kind: lesson.kind)
        viewModels.append(titleViewModel)
    }
    
    private func fillDescriptionViewModel() {
        
        // TODO: Add description view model
    }
    
    private func fillTeacherViewModel() {
        
        guard let teacher = lesson.teacher else {
            return
        }
        
        // FIXME: Add right teacher
        let fakeTeacher = Teacher(firstName: "TEST", lastName: "TEST", department: "TEST")
        fakeTeacher.degree = "TEST"
        
        let teacherViewModel = LessonTeacherCellViewModel(fakeTeacher)
        viewModels.append(teacherViewModel)
    }
    
    private func fillLocationViewModel() {
        
        guard let location = lesson.room else {
            return
        }
        
        let locationViewModel = LessonLocationViewModel(location: location)
        viewModels.append(locationViewModel)
    }
    
    private func fillCalendarViewModel() {
        
        guard let displayedLessons = displayedLessons else {
            return
        }
        
        let calendarViewModel = LessonCalendarCellViewModel(currentLesson: lesson, displayedLessons: displayedLessons)
        viewModels.append(calendarViewModel)
    }
}
