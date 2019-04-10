//
//  DayHeader.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 01/12/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

@IBDesignable

class DayHeader: UITableViewCell, CellViewModelProtocol {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var separatorViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        separatorView.backgroundColor = AppTheme.shared.tableSeparatorColor
        separatorViewHeightConstraint.constant = CGFloat.pixelHeight
    }
    
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
        
        guard let castedModel = model as? DayHeaderViewModel else {
            return
        }
        
        titleLabel.text = castedModel.title
        dateLabel.text = castedModel.subtitle
    }
}
