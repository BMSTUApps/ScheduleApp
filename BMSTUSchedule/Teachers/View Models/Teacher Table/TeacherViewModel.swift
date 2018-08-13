//
//  TeacherViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 13/08/2018.
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
    }
    
    private func fillTitleViewModel() {
        
        let titleViewModel = TeacherTitleCellViewModel(title: teacher.fullName)
        viewModels.append(titleViewModel)
    }
    
    private func fillInfoViewModel() {
        
        guard let position = teacher.position, let degree = teacher.degree else {
            return
        }
        
        let infoViewModel = TeacherInfoCellViewModel(position: position, degree: degree, department: teacher.department)
        viewModels.append(infoViewModel)
    }
}
