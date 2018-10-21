//
//  TeacherTitleCellViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherTitleCellViewModel: CellViewModel {

    var title: String
    
    init(title: String) {
        self.title = title
        
        super.init(identifier: String(describing: TeacherTitleCell.self))

    }
}
