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
    
    var type: Lesson.Kind? {
        get {
            return self.type
        }
        set(new) {
            self.setType(type: type)
        }
    }
    
    // MARK: - Constants
    
    let typeColors = [
        "lecture": Theme.current.greenColor,
        "seminar": Theme.current.blueColor,
        "lab"    : Theme.current.yellowColor,
        "default": UIColor.gray
    ]
    
    let typeRectLeadingOffset: CGFloat = 52
    let typeRectTopOffset: CGFloat = 3.0
    let typeRectThickness: CGFloat = 3.0
    
    // MARK: - Selection
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted {
            self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
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
        
        typeRect.layer.cornerRadius = typeRectThickness
        typeRect.layer.masksToBounds = true
        
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
