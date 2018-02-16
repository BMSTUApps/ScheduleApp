//
//  LessonCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {
    
    @IBOutlet weak var breakLabel: UILabel!

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var kindView: UIView!
    
    let kindColors = [
        "lecture": AppTheme.current.greenColor,
        "seminar": AppTheme.current.blueColor,
        "lab"    : AppTheme.current.yellowColor,
        "default": UIColor.gray
    ]
    
    override func awakeFromNib() {
        
        kindView.layer.cornerRadius = 2
    }
    
    override func prepareForReuse() {
        
        breakLabel.text = ""
        
        startTimeLabel.text = ""
        endTimeLabel.text = ""
        
        titleLabel.text = ""
        
        teacherLabel.text = ""
        roomLabel.text = ""
        kindLabel.text = ""
        kindView.backgroundColor = kindColors["default"]
    }
    
    func fill(model: LessonViewModel) {
        
        breakLabel.text = "15 минут перерыва"
        
        startTimeLabel.text = model.startTime
        endTimeLabel.text = model.endTime
        
        titleLabel.text = model.titleText
        
        teacherLabel.text = model.teacherText
        roomLabel.text = model.roomText
        kindLabel.text = model.kindText
        kindLabel.textColor = kindColors[model.kindText]
        kindView.backgroundColor = kindColors[model.kindText]
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted {
            self.backgroundColor = UIColor.gray.withAlphaComponent(0.15)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
}
