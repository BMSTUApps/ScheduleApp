//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class ScheduleController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var lessons = [Lesson(title: "Теория вероятности", teacher: "Безверхний", room: "230л"),
                   Lesson(title: "Теория вероятности", teacher: "Безверхний", room: "230л"),
                   Lesson(title: "Теория вероятности", teacher: "Безверхний", room: "230л"),
                   Lesson(title: "Теория вероятности", teacher: "Безверхний", room: "230л"),
                   Lesson(title: "Теория вероятности", teacher: "Безверхний", room: "230л")]
    
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        let lesson = lessons[indexPath.row]
        
        cell.titleLabel.text = lesson.title
        cell.teacherLabel.text = lesson.teacher
        cell.roomLabel.text = lesson.room
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
