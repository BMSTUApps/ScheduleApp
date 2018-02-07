//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/*
 Group 👥
 */
class Group: CustomStringConvertible {

    var name: String
    
    var course: Int {
        get {
            let hyphen: Character = "-"
            
            // Finding number
            if let indexOfHyphen = self.name.characters.index(of: hyphen) {
                let numberString = self.name.substring(from: self.name.index(indexOfHyphen, offsetBy: 1))
                
                // Check number
                if let number = Int(numberString) {
                    
                    // Calculate course
                    let course = Int(String(format:"%.f", Double(Double(number) / 20)))
                    return course!
                } else {
                    return 0
                }
            } else {
                return 0
            }
        }
    }
    
    var identifier: String {
        get {
            return "group(\(self.name))"
        }
    }
    
    var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    // MARK: Initialization
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: String())
    }
}
