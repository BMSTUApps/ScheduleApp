//
//  ScheduleStream.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 24/09/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class ScheduleStream {

    enum GetType {
        case current
        case next
        case previous
    }
    
    private var events: [Event]
    private var date: Date
    
    init(events: [Event], startDate: Date = Date.today.previous(.monday, considerToday: true)) {
        self.events = events
        self.date = startDate
    }
    
    // TODO: Improve streaming algorithm
    private func events(from: Date, to: Date) -> [Event] {
        
        var nonRepeatEvents: [Event] = []
        
        for event in events {
            
            let eventDates = dates(for: event, from: from, to: to)
            for eventDate in eventDates {
                
                let nonRepeatEvent = Event(title: event.title, teacher: event.teacher, location: event.location, kind: event.kind, date: eventDate, repeatIn: 0, startTime: event.startTime, endTime: event.endTime)
                nonRepeatEvents.append(nonRepeatEvent)
            }
        }
        
        nonRepeatEvents.sort { (previous, next) -> Bool in
            previous.date < next.date
        }
        
        return nonRepeatEvents
    }
    
    private func dates(for event: Event, from fromDate: Date, to toDate: Date) -> [Date] {
    
        if event.repeatIn == 0 {
            if event.date >= fromDate && event.date <= toDate {
                return [event.date]
            } else {
                return []
            }
        }
        
        var dates: [Date] = []
        var eventDate = event.date
        
        while eventDate <= toDate {
            
            if eventDate >= fromDate {
                dates.append(eventDate)
            }
            
            if let nextDate = eventDate.over(weeksCount: event.repeatIn) {
                eventDate = nextDate
            } else {
                break
            }
        }
        
        return dates
    }
    
    func get(_ type: GetType) -> [Event] {
        
        var targetDate: Date?
        
        switch type {
        case .next:
            targetDate = date.next(.monday)
        case .current:
            targetDate = Date.today.previous(.monday, considerToday: true)
        case .previous:
            targetDate = date.previous(.monday)
        }
        
        guard let from = targetDate else {
            return []
        }
        
        let to = from.next(.sunday)
        
        self.date = from
        
        return events(from: from, to: to)
    }
}
