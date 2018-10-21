//
//  EventLocationCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventLocationCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? EventLocationCellViewModel else {
            return
        }

        locationLabel.text = castedModel.location
        locationDescriptionLabel.text = "(\(castedModel.locationDescription))"
    }
}
