//
//  LessonTimeCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonTimeCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? LessonTimeCellViewModell else {
            return
        }
        
        timeLabel.text = castedModel.timeInterval
    }
}
