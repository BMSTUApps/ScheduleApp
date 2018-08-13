//
//  TeacherAboutCellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherAboutCellViewModel: CellViewModel {

    var about: String
    
    init(_ about: String) {
        self.about = about
        
        super.init(identifier: String(describing: TeacherAboutCell.self))
    }
}
