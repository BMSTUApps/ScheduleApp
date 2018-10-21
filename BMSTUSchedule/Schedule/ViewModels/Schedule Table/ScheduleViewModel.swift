//
//  ScheduleViewModel.swift
//  BMSTUSchedule
//
//  Created by Arthur K1ng on 25/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class ScheduleViewModel {
    
    typealias Section = (header: DayHeaderViewModel?, cells: [CellViewModel])

    var sections: [Section] = []
    let events: [Event]
    
    init(events: [Event], startTermWeekIndex: Int) {
        
        let sortedEvents = events.sorted { (event1, event2) -> Bool in
            return event1.date < event2.date
        }
        
        self.events = sortedEvents
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd.MM.yyyy"
        
        var dayEvents: [Event] = []
        var sections: [Section] = []
        
        var lastDay: String?
        var lastWeekIndex: Int = -1
        for event in sortedEvents {
            
            let currentDay = dayFormatter.string(from: event.date)
            
            // If new day starts
            if let lastDay = lastDay, currentDay != lastDay, let dayDate = dayFormatter.date(from: lastDay) {
                
                let dayCells = dayEvents.compactMap { (event) -> EventCellViewModel in
                    return EventCellViewModel(event)
                }
                
                // If new week starts, add week header
                if lastWeekIndex != dayDate.weekIndex {
                    
                    let weekSection = WeekHeaderViewModel(weekNumber: dayDate.weekIndex - startTermWeekIndex)
                    
                    if let lastSection = sections.last {
                        
                        var newCells = lastSection.cells
                        newCells.append(weekSection)
                        
                        sections[sections.count - 1] = Section(header: lastSection.header, cells: newCells)
                        
                    } else {
                        
                        let firstSection = Section(header: nil, cells: [weekSection])
                        sections.insert(firstSection, at: 0)
                    }
                }
                
                // Add day header and cells
                sections.append(Section(DayHeaderViewModel(date: dayDate), cells: dayCells))
                
                dayEvents = []
                lastWeekIndex = dayDate.weekIndex
            }
            
            dayEvents.append(event)
            lastDay = currentDay
        }
        
        if let lastDay = lastDay, let dayDate = dayFormatter.date(from: lastDay) {
            
            let dayCells = dayEvents.compactMap { (event) -> EventCellViewModel in
                return EventCellViewModel(event)
            }
            
            sections.append(Section(DayHeaderViewModel(date: dayDate), cells: dayCells))
        }
        
        self.sections = sections
    }
    
    convenience init () {
        self.init(events: [], startTermWeekIndex: -1)
    }
    
}

extension ScheduleViewModel: TableViewModelProtocol {
    
    func viewModel(for indexPath: IndexPath) -> CellViewModel? {
        
        return sections[indexPath.section].cells[indexPath.row]
    }
}
