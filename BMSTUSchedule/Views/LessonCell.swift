//
//  LessonCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 26/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit


class LessonCell: UITableViewCell {

    let typeColors = [
        "lecture": UIColor(red: 51/255, green: 187/255, blue: 156/255, alpha: 1),
        "seminar": UIColor(red: 59/255, green: 154/255, blue: 216/255, alpha: 1),
        "lab": UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
    ]
    
    let typeRectLeadingOffset: CGFloat = 52
    let typeRectTopOffset: CGFloat = 3.0
    let typeRectThickness: CGFloat = 3.0
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var breakLabel: UILabel!
    
    func setTypeColor(type: Lesson.LessonType) {
        switch type {
        case .lecture:
            self.typeLabel.textColor = typeColors["lecture"]
        case .seminar:
            self.typeLabel.textColor = typeColors["seminar"]
        case .lab:
            self.typeLabel.textColor = typeColors["lab"]
        }
    }
    
    func drawTypeRect(type: Lesson.LessonType) {
        
        let origin = CGPoint(x:typeRectLeadingOffset, y:typeRectTopOffset)
        let size = CGSize(width:typeRectThickness, height:self.contentView.frame.height - 2 * typeRectTopOffset)
        
        let typeRect = UIView(frame: CGRect(origin: origin, size: size))
        
        switch type {
        case .lecture:
            typeRect.backgroundColor = typeColors["lecture"]
        case .seminar:
            typeRect.backgroundColor = typeColors["seminar"]
        case .lab:
            typeRect.backgroundColor = typeColors["lab"]
        }
        
        self.contentView.addSubview(typeRect)
    }
    
}
