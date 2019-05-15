//
//  Teacher.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 02/05/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

/// Teacher 👨‍🏫
class Teacher: Model {

    let id: String
    
    var firstName: String
    var lastName: String
    var middleName: String?
    
    var department: String
    
    var position: String?
    var degree: String?
    
    var photoURL: URL?
    var about: String?

    override var description : String {
        return "Teacher(\"\(firstName) \(lastName)\")\n"
    }

    var fullName: String {
        return lastName + " " + firstName + " " + (middleName ?? "")
    }
    
    var shortName: String {
        
        guard let firstNameChar = firstName.first, let middleNameChar = middleName?.first else {
            return lastName
        }
        
        return "\(lastName) \(String(firstNameChar)).\(String(middleNameChar))."
    }

    private enum Key: String {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case department
        case position
        case degree
        case photo
        case about
    }
    
    // MARK: Initialization
    
    init?(json: JSON) {
        guard let id = json[Key.id.rawValue] as? String,
            let firstName = json[Key.firstName.rawValue] as? String,
            let lastName = json[Key.lastName.rawValue] as? String,
            let department = json[Key.department.rawValue] as? String else {
            return nil
        }
        
        self.id = id
        
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = json[Key.middleName.rawValue] as? String
        
        self.department = department
        
        self.position = json[Key.position.rawValue] as? String
        self.degree = json[Key.degree.rawValue] as? String
        
        if let rawPhotoURL = json[Key.photo.rawValue] as? String {
            self.photoURL = URL(string: rawPhotoURL)
        }
        
        self.about = json[Key.about.rawValue] as? String
    }
}
