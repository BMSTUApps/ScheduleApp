//
//  Week.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 24/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import Foundation

/// Week 🗓
class Week: CustomStringConvertible {

    enum Kind: String {
        case numerator   = "numerator"
        case denominator = "denominator"
    }

    var number: Int
    var kind: Kind
    
    var days: [Day]

    var description : String {
        return "Week(#\(number) - \"\(kind.rawValue)\")\n"
    }
    
    // MARK: Initialization
    
    init(number: Int, kind: Kind, days: [Day]) {
        self.number = number
        self.kind = kind
        self.days = days
    }
}
