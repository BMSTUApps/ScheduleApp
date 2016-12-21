//
//  GroupCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/12/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    
    var pointerRect: UIView = UIView()
    
    let pointerRectColor = UIColor(red: 51/255, green: 187/255, blue: 156/255, alpha: 1)
    
    let pointerRectLeadingOffset: CGFloat = 6
    let pointerRectTopOffset: CGFloat = 3.0
    let pointerRectThickness: CGFloat = 3.0
    
    let pointerRectDuration = 0.8
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected { // Cell is selected
            if !animated {
                
                // Set to start frame
                self.pointerRect.frame = self.contentView.frame
                self.pointerRect.backgroundColor = self.pointerRectColor.withAlphaComponent(0.2)
                self.addSubview(self.pointerRect)
                
                UIView.animateKeyframes(withDuration: pointerRectDuration, delay: 0, options: .calculationModeCubic, animations: {
                
                    // Animate to end frame
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: self.pointerRectDuration) {
                        let newFrame = CGRect(origin: CGPoint(x: self.pointerRectLeadingOffset, y: self.pointerRectTopOffset),
                                              size: CGSize(width: self.pointerRectThickness,
                                                           height: self.frame.height - 2 * self.pointerRectTopOffset))
                        self.pointerRect.frame = newFrame
                        self.pointerRect.backgroundColor = self.pointerRectColor.withAlphaComponent(0.6)
                    }
                }, completion: {finished in
                    
                    // Fill color
                    self.pointerRect.backgroundColor = self.pointerRectColor.withAlphaComponent(1.0)
                })
                
            } else {
                
                // Set to final frame
                let newFrame = CGRect(origin: CGPoint(x: self.pointerRectLeadingOffset, y: self.pointerRectTopOffset),
                                      size: CGSize(width: self.pointerRectThickness,
                                                   height: self.frame.height - 2 * self.pointerRectTopOffset))
                self.pointerRect.frame = newFrame
                self.addSubview(self.pointerRect)
                
                self.pointerRect.backgroundColor = self.pointerRectColor.withAlphaComponent(1.0)
            }
        } else { // Cell isn't selected
            self.pointerRect.backgroundColor = UIColor.white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted {
            self.contentView.backgroundColor = self.pointerRectColor.withAlphaComponent(0.2)
            self.pointerRect.backgroundColor = self.pointerRectColor.withAlphaComponent(0)
        } else {
            self.contentView.backgroundColor = UIColor.white
            self.pointerRect.backgroundColor = UIColor.white
        }
    }
}
