//
//  DayHeader.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 01/12/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class DayHeader: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

}

class AdvancedDayHeader: UITableViewCell {
    
    // Week information
    @IBOutlet weak var weekNumberLabel: UILabel!
    @IBOutlet weak var weekKindLabel: UILabel!
    
    // Day information
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var dayDateLabel: UILabel!
    
}
