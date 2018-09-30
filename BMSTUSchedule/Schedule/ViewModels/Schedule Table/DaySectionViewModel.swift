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
    
    let eventCellViewModels: [CellViewModel]
    
    init(date: Date, events: [Event]) {
        
        self.title = date.weekDay ?? ""
        self.subtitle = date.string(format: "dd.MM") ?? ""
        
        var eventsViewModels: [EventCellViewModel] = []
        for (index, event) in events.enumerated() {
            
            var brakeText = ""
            
            let isLastEventExist = events.indices.contains(index-1)
            if isLastEventExist {
                brakeText = ScheduleStream.calculateBrake(from: events[index-1], to: event) ?? ""
            }
            
            let eventViewModel = EventCellViewModel(event, brakeText: brakeText)
            eventsViewModels.append(eventViewModel)
        }
        
        self.eventCellViewModels = eventsViewModels
    }
}
