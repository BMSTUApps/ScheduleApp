//
//  EventActionsCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventActionsCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        notifyButton.layer.cornerRadius = 10.0
        editButton.layer.cornerRadius = 10.0
    }

    @IBAction func notifyButtonTapped(_ sender: Any) {
        print("Notify button tapped")
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        print("Edit button tapped")
    }
    
    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard model is EventActionsCellViewModel else {
            return
        }
        
        return
    }
}
