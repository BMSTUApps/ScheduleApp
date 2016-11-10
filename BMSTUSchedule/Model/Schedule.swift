//
//  Schedule.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

class Schedule: Base {

    var numeratorWeek: [Day]
    var denominatorWeek: [Day]
    
    init(numeratorWeek: [Day], denominatorWeek: [Day]) {
        self.numeratorWeek = numeratorWeek
        self.denominatorWeek = denominatorWeek
    }
    
    override convenience init() {
        self.init(numeratorWeek: [], denominatorWeek: [])
    }
    
}
