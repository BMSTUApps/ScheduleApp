//
//  LessonCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {
    
    // MARK: Storyboard
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var breakLabel: UILabel!
    
    // MARK: - Constants
    
    let typeColors = [
        "lecture": UIColor(red: 51/255, green: 187/255, blue: 156/255, alpha: 1), // green
        "seminar": UIColor(red: 59/255, green: 154/255, blue: 216/255, alpha: 1), // blue
        "lab"    : UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1), // yellow
        "default": UIColor.gray
    ]
    
    let typeRectLeadingOffset: CGFloat = 52
    let typeRectTopOffset: CGFloat = 3.0
    let typeRectThickness: CGFloat = 3.0
    
    // MARK: - Type
    
    func setType(type: Lesson.Kind?) {
        self.setTypeTitle(type: type)
        self.setTypeColor(type: type)
        self.drawTypeRect(type: type)
    }
    
    func setTypeColor(type: Lesson.Kind?) {
        if let type = type {
            switch type {
            case .lecture:
                self.typeLabel.textColor = typeColors["lecture"]
            case .seminar:
                self.typeLabel.textColor = typeColors["seminar"]
            case .lab:
                self.typeLabel.textColor = typeColors["lab"]
            }
        }
    }
    
    func setTypeTitle(type: Lesson.Kind?) {
        if type != nil {
            self.typeLabel.text = type?.rawValue
        } else {
            self.typeLabel.text = ""
        }
    }
    
    func drawTypeRect(type: Lesson.Kind?) {
        let origin = CGPoint(x:typeRectLeadingOffset, y:typeRectTopOffset)
        let size = CGSize(width:typeRectThickness, height:self.contentView.frame.height - 2 * typeRectTopOffset)
        
        let typeRect = UIView(frame: CGRect(origin: origin, size: size))
        
        if let type = type {
            switch type {
            case .lecture:
                typeRect.backgroundColor = typeColors["lecture"]
            case .seminar:
                typeRect.backgroundColor = typeColors["seminar"]
            case .lab:
                typeRect.backgroundColor = typeColors["lab"]
            }
        } else {
            typeRect.backgroundColor = typeColors["default"]
        }
        
        self.contentView.addSubview(typeRect)
    }
    
}
