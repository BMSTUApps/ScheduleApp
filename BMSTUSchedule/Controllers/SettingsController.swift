//
//  SettingsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsController: TableViewController {

    @IBOutlet weak var offlineModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set appearance
        self.backButtonColor = UIColor.red
        self.setAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.offlineModeSwitch.isOn = Manager.standard.offlineMode
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
}
    
    // MARK: - Actions
    
    @IBAction func switchModeAction(_ sender: UISwitch) {
        Manager.standard.offlineMode = sender.isOn
    }
}
