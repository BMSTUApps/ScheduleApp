//
//  CalendarManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class CalendarManager {

    // MARK: Constants
    let startWeek: Int = 12
    var currentWeek: Int {
        get {
            let calendar = Calendar.current
            let weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
            return weekOfYear
        }
    }
    
    // MARK: Dates source
    /*
     func daysFromSchedule(shedule: Schedule, offsetFromToday: Int, count: Int) -> [Day] {
     
     let calendar = Calendar.current
     let weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
     print(weekOfYear)
     
     return []
     }
     */
    
}
