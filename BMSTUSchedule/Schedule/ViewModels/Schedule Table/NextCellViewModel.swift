//
//  NextCellViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/10/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class NextCellViewModel: CellViewModel {

    init() {
        
        super.init(identifier: String(describing: NextCell.self))
        
        self.shouldHighlight = false
    }
}
