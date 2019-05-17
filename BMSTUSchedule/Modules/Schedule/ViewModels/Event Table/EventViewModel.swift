//
//  EventViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventViewModel: TableViewModel {
    
    private let event: Event
    private let displayedEvents: [Event]?

    init(_ event: Event, displayedEvents: [Event]? = nil) {
        
        self.event = event
        self.displayedEvents = displayedEvents

        super.init()
        
        fillTitleViewModel()
        fillDescriptionViewModel()
        fillTimeViewModel()
        fillLocationViewModel()
        fillTeacherViewModel()
        fillCalendarViewModel()
        fillActionsViewModel()
    }
    
    private func fillTitleViewModel() {
        
        let titleViewModel = EventTitleCellViewModel(title: event.title, kind: event.kind)
        viewModels.append(titleViewModel)
    }
    
    private func fillDescriptionViewModel() {
        
        // TODO: Add description view model
    }
    
    private func fillTeacherViewModel() {
        
        guard let teacher = event.teacher else {
            return
        }
        
        let teacherViewModel = EventTeacherCellViewModel(teacher)
        viewModels.append(teacherViewModel)
    }
    
    private func fillLocationViewModel() {
        
        guard let location = event.location else {
            return
        }
        
        let locationViewModel = EventLocationCellViewModel(location: location)
        viewModels.append(locationViewModel)
    }
    
    private func fillCalendarViewModel() {
        
        guard let displayedEvents = displayedEvents else {
            return
        }

        // FIXME: Fix transmiting event
//        let calendarViewModel = EventCalendarCellViewModel(currentEvent: event, displayedEvents: displayedEvents)
//        viewModels.append(calendarViewModel)
    }
    
    private func fillTimeViewModel() {
        
        let timeViewModel = EventTimeCellViewModell(startTime: event.startTime, endTime: event.endTime)
        viewModels.append(timeViewModel)
    }
    
    private func fillActionsViewModel() {
        viewModels.append(EventActionsCellViewModel())
    }
}
