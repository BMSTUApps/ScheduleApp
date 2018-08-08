//
//  EventViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventViewModel {
    
    var count: Int {
        return viewModels.count
    }
    
    private var viewModels: [CellViewModel] = []
    private let event: Event
    private let displayedEvents: [Event]?

    init(_ event: Event, displayedEvents: [Event]? = nil) {
        
        self.event = event
        self.displayedEvents = displayedEvents
        
        fillTitleViewModel()
        fillDescriptionViewModel()
        fillTimeViewModel()
        fillLocationViewModel()
        fillTeacherViewModel()
        fillCalendarViewModel()
    }
    
    func viewModel(for indexPath: IndexPath) -> CellViewModel? {
        
        if indexPath.row < viewModels.count {
            return viewModels[indexPath.row]
        }
        
        return nil
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
        
        // FIXME: Add right teacher
        let fakeTeacher = Teacher(firstName: "TEST", lastName: "TEST", department: "TEST")
        fakeTeacher.degree = "TEST"
        
        let teacherViewModel = EventTeacherCellViewModel(fakeTeacher)
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
        
        let calendarViewModel = EventCalendarCellViewModel(currentEvent: event, displayedEvents: displayedEvents)
        viewModels.append(calendarViewModel)
    }
    
    private func fillTimeViewModel() {
        
        let timeViewModel = EventTimeCellViewModell(startTime: event.startTime, endTime: event.endTime)
        viewModels.append(timeViewModel)
    }
}
