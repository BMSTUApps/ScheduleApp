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
    
    var startTermWeekIndex: Int
    
    private var events: [Event]
    private var date: Date
    
    init(events: [Event], startDate: Date = Date.today.previous(.monday, considerToday: true)) {
        self.events = events
        self.date = startDate
        
        // Calculate start term week index
        let sortedEvents = events.sorted { (event1, event2) -> Bool in
            return event1.date < event2.date
        }
        self.startTermWeekIndex = sortedEvents.first?.date.weekIndex ?? -1
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
            
            if previous.date == next.date,
                let previousStartDate = Date(previous.startTime, format: "HH:mm"),
                let nextStartDate = Date(next.startTime, format: "HH:mm") {
                return previousStartDate < nextStartDate
            }
            
            return previous.date < next.date
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
    
    // MARK: Helpers
    
    static func calculateBrake(from previous: Event, to next: Event) -> String? {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "ru-RU")
        
        let date1 = timeFormatter.date(from: previous.endTime)
        let date2 = timeFormatter.date(from: next.startTime)
        
        guard let startBrakeDate = date1, let endBrakeDate = date2 else {
            return nil
        }
        
        let interval = endBrakeDate.timeIntervalSince(startBrakeDate)
        let minutes = Int(interval / 60)
        
        return String(format: "%@ minutes break".localized, "\(minutes)")
    }
    
    struct Week {
        
        enum Kind: String {
            case numerator, denominator
        }
        
        let number: Int
        let type: Kind
    }
    
    static func getCurrentWeek(event: Event) -> Week {
        
        // TODO: Calculate week number
        
        return Week(number: 1, type: .numerator)
    }
}
