//
//  SettingsRowCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 11/03/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsRowCell: UITableViewCell {

    // TODO: Add separators
    
    enum Style {
        case disclosure
        case switcher
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionSwitch: UISwitch!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }
    
    func fill(title: String, style: Style = .disclosure) {
        
        titleLabel.text = title
        
        switch style {
        case .disclosure:
            self.accessoryType = .disclosureIndicator
            self.actionSwitch.isHidden = true
            break
        case .switcher:
            self.accessoryType = .none
            self.actionSwitch.isHidden = false
            break
        }
    }

    // MARK: - UI
    
    private func prepareUI() {
        
        actionSwitch.tintColor = AppTheme.shared.blueColor
    }
}
