//
//  TeacherAboutCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherAboutCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var aboutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? TeacherAboutCellViewModel else {
            return
        }
        
        aboutLabel.text = castedModel.about
    }
}
