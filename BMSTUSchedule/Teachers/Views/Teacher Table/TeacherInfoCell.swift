//
//  TeacherInfoCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherInfoCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoView.layer.cornerRadius = photoView.frame.height / 2
        photoView.clipsToBounds = true
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? TeacherInfoCellViewModel else {
            return
        }
        
        if let url = castedModel.photoUrl {
            photoView.setImage(from: url)
        }
        
        positionLabel.text = castedModel.position
        degreeLabel.text = castedModel.degree
        departmentLabel.text = castedModel.department
    }
}
