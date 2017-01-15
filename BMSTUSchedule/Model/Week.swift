//
//  Week.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 24/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

class Week: Base {

    enum Kind: String {
        case numerator   = "числитель"
        case denominator = "знаменатель"
    }
    
    var kind: Kind
    var days: [Day]

    var number: Int = 0
    
    override var description : String {
        return "Week(#\(number) - \"\(kind.rawValue)\")\n"
    }
    
    // MARK: Initialization
    
    init(kind: Kind, days: [Day]) {
        self.kind = kind
        self.days = days
    }
    
    convenience override init() {
        self.init(kind: .numerator, days: [])
    }
        
}
