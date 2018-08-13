//
//  Teacher.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 02/05/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

/// Teacher 👨‍🏫
class Teacher: CustomStringConvertible {

    var firstName: String
    var lastName: String
    var middleName: String?
    
    var department: String
    
    var position: String?
    var degree: String?
    
    var photoURL: URL?
    var about: String?

    var description : String {
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

    // MARK: Initialization
    
    init(firstName: String, lastName: String, middleName: String? = nil, department: String, position: String? = nil, degree: String? = nil, photoURL: URL? = nil, about: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.department = department
        self.position = position
        self.degree = degree
        self.photoURL = photoURL
        self.about = about
    }
}
