//
//  SettingsGroupCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/04/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsGroupCell: UITableViewCell {
    
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var betweenConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    fileprivate let initialTopConstant: CGFloat = 24
    fileprivate let initialBetweenConstant: CGFloat = 14
    
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
    
    func updateTopOffset(_ offset: CGFloat) {
        
        // FIXME: Fix lugs with parallax
        
        let newOffset = initialTopConstant + offset
        if newOffset < initialTopConstant {
            topConstraint.constant = initialTopConstant + floor(offset / 3)
            betweenConstraint.constant = initialBetweenConstant - floor(offset / 6)
            bottomConstraint.constant = initialTopConstant - floor(offset / 6)
        
            groupLabel.font = groupLabel.font.withSize(36 - floor(offset / 6))
        }
    }

    // MARK: - UI
    
    private func prepareUI() {
        
        self.clipsToBounds = false
        
        changeButton.tintColor = AppTheme.shared.blueColor
        changeButton.backgroundColor = AppTheme.shared.blueColor.withAlphaComponent(0.15)
        changeButton.layer.cornerRadius = 10
    }
}
