//
//  TeacherCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 30/04/2018.
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
    
    func fill(teacher: Teacher) {
    
        if let url = teacher.photoURL {
            photoView.setImage(from: url)
        }
        
        nameLabel.text = teacher.fullName
        positionLabel.text = teacher.position
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        UIView.animate(withDuration: 0.2) {
            
            if highlighted {
                self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
            } else {
                self.transform = CGAffineTransform.identity
            }
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
        photoView.clipsToBounds = true
    }
}
