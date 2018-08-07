//
//  LessonTitleCellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonTitleCellViewModel: CellViewModel {

    var title: String
    var kind: Lesson.Kind
    
     init(title: String, kind: Lesson.Kind) {
        self.title = title
        self.kind = kind

        super.init(identifier: String(describing: LessonTitleCell.self))
    }
}
