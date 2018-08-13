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
    }
    
    private func fillTitleViewModel() {
        
        let titleViewModel = TeacherTitleCellViewModel(title: teacher.fullName)
        viewModels.append(titleViewModel)
    }
}
