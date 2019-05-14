//
//  User.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 14/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation

/// User 👀
class User: Model {

    var email: String
    
    var firstName: String
    var lastName: String
    var middleName: String
    
    var photo: URL?
    
    var schedule: [Event]
    
    // MARK: Initialization
    
    private enum Key: String {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case scheduleID = "schedule_id"
    }
    
    init?(json: JSON) {
        guard let email = json[Key.email.rawValue] as? String, let scheduleID = json[Key.scheduleID.rawValue] as? Int else {
            return nil
        }
        
        self.email = email
        
        self.firstName = json[Key.firstName.rawValue] as? String ?? ""
        self.lastName = json[Key.lastName.rawValue] as? String ?? ""
        self.middleName = json[Key.middleName.rawValue] as? String ?? ""
        
        // TODO: Build schedule
        self.schedule = []
    }
}
