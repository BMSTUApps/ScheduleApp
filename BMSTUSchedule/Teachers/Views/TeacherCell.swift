//
//  TeacherCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 30/04/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var liningView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }
    
    func fill() {
    
        photoView.image = #imageLiteral(resourceName: "test_teacher")
        nameLabel.text = "Абулкасимов Манас Мукитович"
        positionLabel.text = "старший преподаватель"
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted {
            liningView.backgroundColor = UIColor.gray.withAlphaComponent(0.15)
        } else {
            liningView.backgroundColor = UIColor.white
        }
    }

    // MARK: - UI
    
    private func prepareUI() {

        self.clipsToBounds = false

        liningView.layer.cornerRadius = 15.0
        
        liningView.layer.shadowColor = UIColor.black.cgColor
        liningView.layer.shadowOpacity = 0.05
        liningView.layer.shadowOffset = CGSize(width: 0, height: 0)
        liningView.layer.shadowRadius = 15
        
        liningView.layer.shadowPath = UIBezierPath(rect: liningView.bounds).cgPath
        liningView.layer.shouldRasterize = true
        liningView.layer.rasterizationScale = UIScreen.main.scale
        
        photoView.layer.cornerRadius = photoView.frame.height / 2
    }
}
