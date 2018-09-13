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
    let subtitle: String
    
    let eventCellViewModels: [EventCellViewModel]
    
    init(date: Date, events: [Event]) {
        
        self.title = date.weekDay ?? ""
        self.subtitle = date.string(format: "dd.MM") ?? ""
        
        var eventsViewModels: [EventCellViewModel] = []
        for (index, event) in events.enumerated() {
            
            var brakeText = ""
            
            let isLastEventExist = events.indices.contains(index-1)
            if isLastEventExist {
                brakeText = AppManager.shared.calculateBrake(currentEvent: events[index-1], nextEvent: event) ?? ""
            }
            
            let eventViewModel = EventCellViewModel(event, brakeText: brakeText)
            eventsViewModels.append(eventViewModel)
        }
        
        self.eventCellViewModels = eventsViewModels
    }
}
