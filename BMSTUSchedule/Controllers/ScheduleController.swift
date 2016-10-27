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
    
    var lessons: [[Lesson]] = []
    var daysTitles = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
    
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
        
        // Create test lessons
        for _ in 0...self.daysTitles.count-1 {
            
            let dayLessonsCount = arc4random_uniform(5) + 1
            var dayLessons: [Lesson] = []
            
            for _ in 0...dayLessonsCount {
                dayLessons.append(Lesson(title: "Теория вероятности",
                                         teacher: "Безверхний Н.В.",
                                         room: "230л",
                                         type: .lecture,
                                         startTime: "12:00",
                                         endTime: "13:35"))
            }

            lessons.append(dayLessons)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return lessons.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return daysTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        let lesson = lessons[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = lesson.title
        
        cell.teacherLabel.text = lesson.teacher
        cell.roomLabel.text = lesson.room
        
        cell.startTimeLabel.text = lesson.startTime
        cell.endTimeLabel.text = lesson.endTime
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
