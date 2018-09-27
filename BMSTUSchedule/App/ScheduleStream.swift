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
    
    init(events: [Event], startDate: Date) {
        self.events = events
        self.date = startDate
    }
    
    private func events(from: Date, to: Date) -> [Event] {
        
        // TODO: Algorithm of streaming
        
        return events
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
