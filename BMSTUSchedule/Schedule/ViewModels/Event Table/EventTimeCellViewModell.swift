//
//  EventTimeCellViewModell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventTimeCellViewModell: CellViewModel {

    var timeInterval: String
    
    init(startTime: String, endTime: String) {
        
        self.timeInterval = "\(startTime) — \(endTime)"
        
        super.init(identifier: String(describing: EventTimeCell.self))
    }
}
