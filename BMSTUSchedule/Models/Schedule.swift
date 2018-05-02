//
//  Schedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/// Schedule 🗂
class Schedule: CustomStringConvertible {

    var group: Group
    var weeks: [Week]
    
    var description : String {
        return "Schedule(weeksCount: \(weeks.count))"
    }
    
    // MARK: Initialization
    
    init(group: Group, weeks: [Week]) {
        self.group = group
        self.weeks = weeks
    }
}
