//
//  LessonTeacherCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonTeacherCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        photoView.layer.cornerRadius = photoView.frame.height / 2
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? LessonTeacherCellViewModel else {
            return
        }
        
        //photoView.image = castedModel.photoUrl
        
        fullNameLabel.text = castedModel.fullName
        degreeLabel.text = castedModel.degree
    }
}
