//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit
import Firebase

class ScheduleController: UITableViewController {
    
    var schedule = Schedule()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Menu button
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    
        // Remove empty cells
        tableView.tableFooterView = UIView()

        // Load schedule
        ScheduleManager.sharedManager.getSchedule(group: Group(name: "ИУ5-33"), success: { schedule in
            self.schedule = schedule
            self.tableView.reloadData()
        })
        
        self.tableView.sectionHeaderHeight = 40
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return schedule.numeratorWeek.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerView.backgroundColor = UIColor.groupTableViewBackground
        
        let titleLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 200, height: 40))
        titleLabel.text = schedule.numeratorWeek[section].title.rawValue.capitalized
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return schedule.numeratorWeek[section].title.rawValue.capitalized   
    }
    */
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.numeratorWeek[section].lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        let lesson = schedule.numeratorWeek[indexPath.section].lessons[indexPath.row]
        
        cell.titleLabel.text = lesson.title
        
        cell.teacherLabel.text = lesson.teacher
        cell.roomLabel.text = lesson.room
        cell.setType(type: lesson.type)
        
        cell.startTimeLabel.text = lesson.startTime
        cell.endTimeLabel.text = lesson.endTime
        
        return cell
    }

    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
