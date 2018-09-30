//
//  ViewController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 04/06/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localize tabBar titles
        self.tabBarController?.tabBar.items?[0].title = "Schedule".localized
        self.tabBarController?.tabBar.items?[1].title = "Teachers".localized
        self.tabBarController?.tabBar.items?[2].title = "Settings".localized
    }
}
