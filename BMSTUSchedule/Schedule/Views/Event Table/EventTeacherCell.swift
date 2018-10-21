//
//  EventTeacherCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventTeacherCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    @IBOutlet weak var highlightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        photoView.layer.cornerRadius = photoView.frame.height / 2
        photoView.clipsToBounds = true
        
        highlightView.layer.cornerRadius = 15
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted {
            highlightView.backgroundColor = AppTheme.shared.tableSelectionColor
        } else {
            highlightView.backgroundColor = UIColor.clear
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if selected {
            highlightView.backgroundColor = AppTheme.shared.tableSelectionColor
        } else {
            highlightView.backgroundColor = UIColor.clear
        }
    }
    
    override func prepareForReuse() {
        
        highlightView.backgroundColor = UIColor.clear
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
