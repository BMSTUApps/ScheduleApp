//
//  EventTeacherCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventTeacherCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        photoView.layer.cornerRadius = photoView.frame.height / 2
        photoView.clipsToBounds = true
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? EventTeacherCellViewModel else {
            return
        }
        
        if let url = castedModel.photoUrl {
            photoView.setImage(from: url)
        }
        
        fullNameLabel.text = castedModel.fullName
        degreeLabel.text = castedModel.degree
    }
}
