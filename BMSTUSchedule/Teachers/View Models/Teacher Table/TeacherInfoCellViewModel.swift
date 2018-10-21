//
//  TeacherInfoCellViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherInfoCellViewModel: CellViewModel {

    var photoUrl: URL?
    var position: String
    var degree: String
    var department: String

    init(photoUrl: URL? = nil, position: String, degree: String, department: String) {
        
        self.photoUrl = photoUrl
        self.position = position
        self.degree = degree
        self.department = department
        
        super.init(identifier: String(describing: TeacherInfoCell.self))
    }
}
