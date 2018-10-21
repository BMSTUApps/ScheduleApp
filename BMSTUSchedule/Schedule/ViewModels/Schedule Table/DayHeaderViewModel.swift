//
//  DayHeaderViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/10/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class DayHeaderViewModel: CellViewModel {

    let title: String
    let subtitle: String
    
    init(date: Date) {
        
        self.title = date.weekday?.capitalized ?? ""
        self.subtitle = date.string(format: "dd.MM") ?? ""
        
        super.init(identifier: String(describing: DayHeader.self))
        
        self.shouldHighlight = false
    }
}
