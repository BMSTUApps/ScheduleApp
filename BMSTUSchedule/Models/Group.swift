//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation


/// Group 👥
class Group: CustomStringConvertible {

    var name: String {
        didSet {
            self.department = parseDepartment(name)
            self.number = parseNumber(name)
            self.course = parseCourse(name)
        }
    }
    
    var department: String
    var number: Int
    
    var course: Int

    var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    // MARK: Initialization
    
    init(name: String) {
        self.name = name
        self.department = ""
        self.number = 0
        self.course = 0
    }

    // MARK: Parsing
    
    func parseDepartment(_ name: String) -> String {
        
        let hyphen: Character = "-"
        
        // Finding department
        if let indexOfHyphen = name.index(of: hyphen) {
            let department = String(name.prefix(upTo: indexOfHyphen))
            
            return department
        }
        
        return ""
    }
    
    func parseNumber(_ name: String) -> Int {
        
        let hyphen: Character = "-"
        
        // Finding number
        if let indexOfHyphen = name.index(of: hyphen) {
            let number = Int(name.suffix(from: indexOfHyphen)) ?? 0
            
            return number
        }
        
        return 0
    }
    
    func parseCourse(_ name: String) -> Int {
        
        let hyphen: Character = "-"

        // Finding course
        if let indexOfHyphen = name.index(of: hyphen) {
            let number = Int(name.suffix(from: indexOfHyphen)) ?? 0
            
            // Calculate course
            let course = Int(String(format:"%.f", Double(Double(number) / 20))) ?? 0
            
            return course
        }
        
        return 0
    }
}
