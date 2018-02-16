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
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var kindView: UIView!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var breakLabel: UILabel!
    
    var kind: Lesson.Kind? {

        didSet {
            self.setKind(kind: kind)
        }
    }
    
    override func awakeFromNib() {
        
        kindView.layer.cornerRadius = 2
    }
    
    // MARK: - Constants
    
    let kindColors = [
        "lecture": AppTheme.current.greenColor,
        "seminar": AppTheme.current.blueColor,
        "lab"    : AppTheme.current.yellowColor,
        "default": UIColor.gray
    ]
    
    // MARK: - Selection
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted {
            
            var key = "default"
            if let kind = kind {
                switch kind {
                case .lecture:
                    key = "lecture"
                case .seminar:
                    key = "seminar"
                case .lab:
                    key = "lab"
                case .undefined:
                    key = "default"
                }
            }
            self.backgroundColor = kindColors[key]?.withAlphaComponent(0.15)
            
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    // MARK: - Kind
    
    func setKind(kind: Lesson.Kind?) {
        self.setKindTitle(kind: kind)
        self.setKindColor(kind: kind)
    }
    
    func setKindColor(kind: Lesson.Kind?) {
        
        if let kind = kind {
            switch kind {
            case .lecture:
                kindLabel.textColor = kindColors["lecture"]
                kindView.backgroundColor = kindColors["lecture"]
            case .seminar:
                kindLabel.textColor = kindColors["seminar"]
                kindView.backgroundColor = kindColors["seminar"]
            case .lab:
                kindLabel.textColor = kindColors["lab"]
                kindView.backgroundColor = kindColors["lab"]
            case .undefined:
                kindLabel.textColor = kindColors["default"]
                kindView.backgroundColor = kindColors["default"]
            }
        }
    }
    
    func setKindTitle(kind: Lesson.Kind?) {
        
        if kind != nil {
            self.kindLabel.text = kind?.rawValue
        } else {
            self.kindLabel.text = ""
        }
    }
}
