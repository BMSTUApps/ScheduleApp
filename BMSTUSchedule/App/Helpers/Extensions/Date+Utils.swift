//
//  Date+Utils.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

extension Date {

    var weekDay: String? {
        return string(format: "EEEE")
    }
    
    init?(_ string: String, format: String = "dd.MM") {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format

        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    func string(format: String) -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
