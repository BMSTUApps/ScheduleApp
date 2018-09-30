//
//  NextCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 28/09/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class NextCell: UITableViewCell {

    @IBOutlet weak var nextImageView: UIImageView!
    
    override func awakeFromNib() {

        // Initial setup
    }
    
    override func prepareForReuse() {
        
        // Prepare for reuse
    }
    
    func fill(model: NextCellViewModel) {
        
        nextImageView.image = model.image
    }
}
