//
//  TeacherSearchCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 19/11/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherSearchCell: UITableViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareUI()
    }

    // MARK: - UI
    
    private func prepareUI() {
        
        self.selectionStyle = .none

        self.searchBar.barTintColor = UIColor.white
    }
}
