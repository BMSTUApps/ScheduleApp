//
//  Schedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

class Schedule: Base {

    var numeratorWeek: Week
    var denominatorWeek: Week
    
    override var description : String {
        return "Schedule(numeratorWeek: \(numeratorWeek.days.count) lessons, denominatorWeek: \(denominatorWeek.days.count) lessons)\n"
    }
    
    // MARK: Initialization
    
    init(numeratorWeek: Week, denominatorWeek: Week) {
        self.numeratorWeek = numeratorWeek
        self.denominatorWeek = denominatorWeek
    }
    
    override convenience init() {
        self.init(numeratorWeek: Week(), denominatorWeek: Week())
    }
    
}
