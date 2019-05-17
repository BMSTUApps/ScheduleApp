//
//  RealmTeacher.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTeacher: Object {
    
    @objc dynamic var serverID: Int = 0
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var middleName: String? = nil

    @objc dynamic var department: String = ""

    @objc dynamic var position: String? = nil
    @objc dynamic var degree: String? = nil

    @objc dynamic var photoURL: String? = nil
    @objc dynamic var about: String? = nil
}

// MARK: - Model linking

extension RealmTeacher {
    
    convenience init(_ model: Teacher) {
        self.init()
        
        self.serverID = model.id
        
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.middleName = model.middleName
        
        self.department = model.department
        
        self.position = model.position
        self.degree = model.degree
        
        self.photoURL = model.photoURL?.absoluteString
        self.about = model.about
    }
}
