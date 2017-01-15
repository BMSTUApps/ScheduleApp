//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Firebase

class Group: Base {

    var name: String
    
    let key: String
    let ref: FIRDatabaseReference?
    
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
    
    override var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    // MARK: Initialization
    
    init(name: String, key: String = "") {
        self.key = key
        self.ref = nil
        
        self.name = name
    }
    
    override convenience init() {
        self.init(name: String())
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        if let snapshotValue = snapshot.value as? [String: AnyObject] {
            name = snapshotValue["name"] as! String
        } else {
            name = ""
        }
    }
    
    // MARK: Equatable
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        
        return lhs.name == rhs.name
    }
    
    // MARK: Export
    
    func toAnyObject() -> Any {
        return [
            "name": name,
        ]
    }
    
}
