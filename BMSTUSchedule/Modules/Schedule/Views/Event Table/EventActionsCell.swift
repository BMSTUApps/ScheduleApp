//
//  EventActionsCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

protocol EventActionsCellDelegate: TableCellDelegate {
    func onNotify()
    func onEdit()
}

class EventActionsCell: TableCell, CellViewModelProtocol {

    weak var actionsDelegate: EventActionsCellDelegate! {
        return (delegate as! EventActionsCellDelegate)
    }
    
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        notifyButton.layer.cornerRadius = 10.0
        editButton.layer.cornerRadius = 10.0
    }

    @IBAction func notifyButtonTapped(_ sender: Any) {
        actionsDelegate?.onNotify()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        actionsDelegate?.onEdit()
    }
    
    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard model is EventActionsCellViewModel else {
            return
        }
        
        return
    }
}
