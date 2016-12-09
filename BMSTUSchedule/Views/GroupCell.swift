//
//  GroupCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/12/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
