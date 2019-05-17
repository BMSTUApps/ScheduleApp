//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

// TODO: Combine parsing into 1 method

/// Group 👥
final class Group: Model {
    
    let id: ID
    
    let department: String
    let number: Int

    var name: String {
        return "\(department)-\(number)"
    }
    
    override var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    // MARK: Initialization
    
    private enum Key: String {
        case id
        case department
        case number
        case scheduleID = "schedule_id"
    }
    
    init?(json: JSON) {
        guard let id = json[Key.id.rawValue] as? String,
            let department = json[Key.department.rawValue] as? String,
            let number = json[Key.number.rawValue] as? Int,
            let scheduleID = json[Key.scheduleID.rawValue] as? String else {
                return nil
        }
        
        self.id = id
        self.department = department
        self.number = number
        // TODO: Get schedule
    }
}
