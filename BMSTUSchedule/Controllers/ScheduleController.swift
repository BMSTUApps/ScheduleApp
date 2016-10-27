//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class ScheduleController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var lessons = [Lesson(title: "Предмет 1"),
                   Lesson(title: "Предмет 2"),
                   Lesson(title: "Предмет 3"),
                   Lesson(title: "Предмет 4"),
                   Lesson(title: "Предмет 5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Menu button
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
