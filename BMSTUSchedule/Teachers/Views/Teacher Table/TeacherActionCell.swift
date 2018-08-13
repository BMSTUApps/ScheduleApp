//
//  TeacherActionCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherActionCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var showScheduleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        showScheduleButton.layer.cornerRadius = 10.0
    }

    @IBAction func showScheduleButtonTapped(_ sender: Any) {
        print("Show schedule button tapped")
    }
    
    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? TeacherActionCellViewModel else {
            return
        }
        
        return
    }
}
