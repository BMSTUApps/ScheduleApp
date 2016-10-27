//
//  LessonCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
