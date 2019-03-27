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
    
    fileprivate let initialTopConstant: CGFloat = 24
    fileprivate let maxGroupLabelScale: CGFloat = 1.6
    
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
        let colorAttributes = [NSAttributedString.Key.foregroundColor: AppTheme.shared.blueColor]
        let attributedNumber = NSAttributedString(string: components[1], attributes: colorAttributes)
        
        attributedDepartment.append(attributedNumber)
        groupLabel.attributedText = attributedDepartment
    }
    
    func updateTopOffset(_ offset: CGFloat) {
                
        let newOffset = initialTopConstant + offset
        if newOffset < initialTopConstant {

            // Group Label
            
            var groupLabelTransform = CGAffineTransform.identity
    
            let deltaY = offset / 2
            groupLabelTransform = groupLabelTransform.translatedBy(x: 0, y: deltaY)
            
            let currentY = groupLabel.frame.origin.y
            let newY = currentY + deltaY
            
            var deltaHeight = abs(newY - currentY) * 2 / groupLabel.frame.height + 1
            
            if deltaHeight > maxGroupLabelScale {
                deltaHeight = maxGroupLabelScale
            }
            
            groupLabelTransform = groupLabelTransform.scaledBy(x: deltaHeight, y: deltaHeight)
            
            groupLabel.transform = groupLabelTransform
            
            // Change Button
            
            let delta = offset / 4
            changeButton.transform = CGAffineTransform.identity.translatedBy(x: 0, y: delta)
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
