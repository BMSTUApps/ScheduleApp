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
    
    init(_ lesson: Lesson) {
        
        self.lesson = lesson
        
        fillTitleViewModel()
        fillDescriptionViewModel()
        fillTeacherViewModel()
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
}
