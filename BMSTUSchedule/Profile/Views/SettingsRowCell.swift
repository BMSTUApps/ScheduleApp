//
//  SettingsRowCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 11/03/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsRowCell: UITableViewCell {

    enum Style {
        case disclosure
        case switcher
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }
    
    func prepareUI() {
        //
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
