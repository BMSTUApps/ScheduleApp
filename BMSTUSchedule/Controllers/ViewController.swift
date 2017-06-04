//
//  ViewController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 04/06/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var backButtonColor = UIColor.lightGray
    var backButtonTitle = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setCustomBackButton();
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
