//
//  TeacherViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherViewModel: TableViewModel {

    private let teacher: Teacher
    
    init(_ teacher: Teacher) {
        self.teacher = teacher
        
        super.init()
        
        fillTitleViewModel()
        fillInfoViewModel()
        fillAboutViewModel()
        fillActionViewModel()
    }
    
    private func fillTitleViewModel() {
        
        let titleViewModel = TeacherTitleCellViewModel(title: teacher.fullName)
        viewModels.append(titleViewModel)
    }
    
    private func fillInfoViewModel() {
        
        guard let position = teacher.position, let degree = teacher.degree else {
            return
        }
        
        let infoViewModel = TeacherInfoCellViewModel(photoUrl: teacher.photoURL, position: position, degree: degree, department: teacher.department)
        viewModels.append(infoViewModel)
    }
    
    private func fillAboutViewModel() {
        
        guard let about = teacher.about else {
            return
        }
        
        let aboutViewModel = TeacherAboutCellViewModel(about)
        viewModels.append(aboutViewModel)
    }
    
    private func fillActionViewModel() {
        viewModels.append(TeacherActionCellViewModel())
    }
}
