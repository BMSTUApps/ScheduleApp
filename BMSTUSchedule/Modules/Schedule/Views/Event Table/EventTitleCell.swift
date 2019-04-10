//
//  EventTitleCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventTitleCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var kindView: UIView!
    
    // FIXME: Create kind colors in Theme
    let kindColors = [
        "lecture": AppTheme.shared.greenColor,
        "seminar": AppTheme.shared.blueColor,
        "lab"    : AppTheme.shared.yellowColor,
        "other"  : UIColor.gray
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()

        kindView.layer.cornerRadius = kindView.frame.height / 2
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? EventTitleCellViewModel else {
            return
        }
        
        titleLabel.text = castedModel.title
        
        kindLabel.text = castedModel.kind.localizedValue
        kindView.backgroundColor = kindColors[castedModel.kind.rawValue]
    }
}
