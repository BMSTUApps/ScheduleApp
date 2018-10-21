//
//  NextCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/10/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

protocol NextCellProtocol {
    func updateBubbleHeight(_ height: CGFloat)
}

class NextCell: UITableViewCell, NextCellProtocol {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var bubbleViewHeightConstant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        bubbleView.layer.cornerRadius = bubbleView.frame.height / 2
        bubbleView.backgroundColor = AppTheme.shared.blueColor
    }
    
    func updateBubbleHeight(_ height: CGFloat) {
        
        let scale: CGFloat = bubbleViewHeightConstant.constant / height
        
        bubbleView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
    }
}
