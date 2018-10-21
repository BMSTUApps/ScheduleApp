//
//  WeekHeader.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 20/10/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

@IBDesignable

class WeekHeader: UITableViewCell, CellViewModelProtocol {
    
    // MARK: Outlets
    
    @IBOutlet weak var weekNumberLabel: UILabel!
    
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
    
    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? WeekHeaderViewModel else {
            return
        }
        
        weekNumberLabel.text = castedModel.title
    }
}
