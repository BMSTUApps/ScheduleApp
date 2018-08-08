//
//  LessonLocationCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonLocationCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? LessonLocationCellViewModel else {
            return
        }

        locationLabel.text = castedModel.location
        locationDescriptionLabel.text = "(\(castedModel.locationDescription))"
    }
}
