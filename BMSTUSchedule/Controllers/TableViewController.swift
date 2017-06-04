//
//  TableViewController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 04/06/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var backButtonColor = UIColor.lightGray
    var backButtonTitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setCustomBackButton();
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // MARK: Custom appearance
    
    func setCustomBackButton() {
        
        let backImage = UIImage(named: "Back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: backButtonTitle, style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = backButtonColor
    }
}
