//
//  EventTitleCellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventTitleCellViewModel: CellViewModel {

    var title: String
    var kind: Event.Kind
    
     init(title: String, kind: Event.Kind) {
        self.title = title
        self.kind = kind

        super.init(identifier: String(describing: EventTitleCell.self))
    }
}
