//
//  StreamEvent.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 16/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

/// Streaming Event 🎓
final class StreamingEvent: Model {

    let id: ID
    
    let title: String
    
    let teacher: Teacher?

    let location: Event.Location?
    let kind: Event.Kind
    
    let date: Date
    
    let startTime: String
    let endTime: String
    
    // MARK: Initialization

    init(_ event: Event, date: Date) {
        self.id = event.id
        
        self.title = event.title
        
        self.teacher = event.teacher
        
        self.location = event.location
        self.kind = event.kind
        
        self.date = date
    
        self.startTime = event.startTime
        self.endTime = event.endTime
    }
}
