//
//  EventCalendarCellViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventCalendarCellViewModel: CellViewModel {

    var currentEvent: Event
    var displayedEvents: [Event]
    
    init(currentEvent: Event, displayedEvents: [Event]) {
        
        self.currentEvent = currentEvent
        self.displayedEvents = displayedEvents
        
        super.init(identifier: String(describing: EventCalendarCell.self))
    }
}
