//
//  SettingsGroupCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 21/04/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsGroupCell: UITableViewCell {
    
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }

    func fill(groupName: String) {
        
        let components = groupName.components(separatedBy: "-")
        guard components.count == 2 else {
            return
        }
        
        // Set department
        let attributedDepartment = NSMutableAttributedString(string: components[0] + "-")
        
        // Set number
        let colorAttributes = [NSAttributedStringKey.foregroundColor: AppTheme.shared.blueColor]
        let attributedNumber = NSAttributedString(string: components[1], attributes: colorAttributes)
        
        attributedDepartment.append(attributedNumber)
        groupLabel.attributedText = attributedDepartment
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - UI
    
    private func prepareUI() {
        
        // FIXME: Set colors from theme
    }
}
