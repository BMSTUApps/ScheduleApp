//
//  LessonTeacherCellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonTeacherCellViewModel: CellViewModel {

    var photoUrl: URL?
   
    var fullName: String
    var degree: String?
    
    init(_ teacher: Teacher) {
        
        self.photoUrl = teacher.photoURL
        
        self.fullName = teacher.fullName
        self.degree = teacher.degree
        
        super.init(identifier: String(describing: LessonTeacherCell.self))
    }
}
