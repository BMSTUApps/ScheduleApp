//
//  SettingsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Menu button
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
