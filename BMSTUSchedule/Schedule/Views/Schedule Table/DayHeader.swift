//
//  DayHeader.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 01/12/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

@IBDesignable

class DayHeader: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    // MARK: - IBInspectable
    
    @IBInspectable var today: Bool = false {
        didSet {
            if today {
                self.contentView.backgroundColor = self.todayColor
            } else {
                self.contentView.backgroundColor = UIColor.groupTableViewBackground
            }
        }
    }
    
    @IBInspectable var todayColor: UIColor = UIColor(red:206/255, green:229/255, blue:241/255, alpha: 1) {
        didSet {
            if today {
                self.contentView.backgroundColor = self.todayColor
            }
        }
    }
}
