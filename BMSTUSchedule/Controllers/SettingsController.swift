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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.offlineModeSwitch.isOn = Manager.standard.offlineMode
    }
    
    // MARK: - Actions
    
    @IBAction func switchModeAction(_ sender: UISwitch) {
        Manager.standard.offlineMode = sender.isOn
    }
}
