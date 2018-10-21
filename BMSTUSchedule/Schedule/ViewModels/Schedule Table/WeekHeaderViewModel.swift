//
//  WeekHeaderCellViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/10/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class WeekHeaderViewModel: CellViewModel {

    let title: String
    
    init(weekNumber: Int) {
        
        self.title = "\(weekNumber) \("Week".localized.lowercased())"
        
        super.init(identifier: String(describing: WeekHeader.self))
        
        self.shouldHighlight = false
    }
}
