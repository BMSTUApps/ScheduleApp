//
//  Schedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

/*
 Schedule 🗂
 */
class Schedule: CustomStringConvertible {

    var numeratorWeek: Week
    var denominatorWeek: Week
    
    var description : String {
        return "Schedule(numeratorWeek: \(numeratorWeek.days.count) days, denominatorWeek: \(denominatorWeek.days.count) days)\n"
    }
    
    // MARK: Initialization
    
    init(numeratorWeek: Week, denominatorWeek: Week) {
        self.numeratorWeek = numeratorWeek
        self.denominatorWeek = denominatorWeek
    }
    
    convenience init() {
        self.init(numeratorWeek: Week(), denominatorWeek: Week())
    }
}
