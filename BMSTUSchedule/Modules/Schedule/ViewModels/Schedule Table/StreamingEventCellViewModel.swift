//
//  StreamingEventCellViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 15/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

class StreamingEventCellViewModel: CellViewModel {
    
    let brakeText: String
    let kindText: String
    
    let titleText: String
    
    let teacherText: String
    let roomText: String

    let startTime: String
    let endTime: String
    
    let streamingEvent: StreamingEvent
    
    init(_ event: StreamingEvent, brakeText: String = "") {
        
        self.brakeText = brakeText
        
        if event.kind == .other {
            self.kindText = ""
        } else {
            self.kindText = event.kind.rawValue
        }
        
        self.titleText = event.title
        
        self.teacherText = event.teacher?.shortName ?? ""
        self.roomText = event.location ?? ""
        
        self.startTime = event.startTime
        self.endTime = event.endTime
        
        self.streamingEvent = event
        
        super.init(identifier: String(describing: StreamingEventCell.self))
        
        self.shouldHighlight = true
    }
}
