//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Firebase

class Group: Base {

    var name: String
    
    override var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    let key: String
    let ref: FIRDatabaseReference?
    
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
    
    // MARK: Export
    
    func toAnyObject() -> Any {
        return [
            "name": name,
        ]
    }
    
}
