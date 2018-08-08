//
//  DayViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 15/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class DaySectionViewModel {

    let title: String
    let events: [EventCellViewModel]
    
    init(_ day: Day) {
        
        self.title = day.title.rawValue
        
        var eventsViewModels: [EventCellViewModel] = []
        for (index, event) in day.events.enumerated() {
            
            var brakeText = ""
            
            let isLastEventExist = day.events.indices.contains(index-1)
            if isLastEventExist {
                brakeText = AppManager.shared.calculateBrake(currentEvent: day.events[index-1], nextEvent: event) ?? ""
            }
            
            let eventViewModel = EventCellViewModel(event, brakeText: brakeText)
            eventsViewModels.append(eventViewModel)
        }
        self.events = eventsViewModels
    }
}
