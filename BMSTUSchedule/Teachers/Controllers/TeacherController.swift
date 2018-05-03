//
//  TeacherController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 03/05/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

    // MARK: - UI
    
    func prepareUI() {
        
        // Set title
        self.navigationItem.title = "Teacher".localized        
    }
}
