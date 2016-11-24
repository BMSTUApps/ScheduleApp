//
//  Group.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 10/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

class Group: Base {

    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    override var description : String {
        return "Group(\"\(name)\")\n"
    }
    
    override convenience init() {
        self.init(name: String())
    }
    
}
