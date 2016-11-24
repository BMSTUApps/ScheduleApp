//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

class Group: Base {

    var name: String
    
    override var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    // MARK: Initialization
    
    init(name: String) {
        self.name = name
    }
    
    override convenience init() {
        self.init(name: String())
    }
    
}
