//
//  ScheduleViewModel.swift
//  BMSTUSchedule
//
//  Created by Arthur K1ng on 25/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class ScheduleViewModel {

    var daySectionViewModels: [DaySectionViewModel]
    
    init(events: [Event]) {
        
        let sortedEvents = events.sorted { (event1, event2) -> Bool in
            return event1.date < event2.date
        }
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd.MM.yyyy"
        
        var dayEvents: [Event] = []
        var daySectionViewModels: [DaySectionViewModel] = []
        
        var lastDay: String?
        for event in sortedEvents {
            
            let currentDay = dayFormatter.string(from: event.date)
            
            if let lastDay = lastDay, currentDay != lastDay, let dayDate = dayFormatter.date(from: lastDay) {
                daySectionViewModels.append(DaySectionViewModel(date: dayDate, events: dayEvents))
                dayEvents = []
            }
            
            dayEvents.append(event)
            lastDay = currentDay
        }
        
        if let lastDay = lastDay, let dayDate = dayFormatter.date(from: lastDay) {
            daySectionViewModels.append(DaySectionViewModel(date: dayDate, events: dayEvents))
        }
        
        self.daySectionViewModels = daySectionViewModels
    }
    
    convenience init () {
        self.init(events: [])
    }
    
}

extension ScheduleViewModel: TableViewModelProtocol {
    
    func viewModel(for indexPath: IndexPath) -> CellViewModel? {
        
        guard indexPath.section < daySectionViewModels.count else {
            return nil
        }

        let day = daySectionViewModels[indexPath.section]
        
        guard indexPath.row < day.eventCellViewModels.count else {
            return nil
        }
        
        return day.eventCellViewModels[indexPath.row]
    }
}
