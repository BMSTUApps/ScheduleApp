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
    
    var days: [Day] = []
    
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
        Manager.firebaseManager.getSchedule(group: Manager.manager.currentGroup!, success: { schedule in
            let weeks = Manager.calendarManager.createWeeksFromSchedule(schedule: schedule, offset: 0, count: 2)
            self.setWeeks(weeks: weeks)
            self.tableView.reloadData()
        })
        
        self.tableView.sectionHeaderHeight = 40
    }
    
    // MARK: - Setting table
    
    func setSchedule(schedule: Schedule) {
        self.days = schedule.denominatorWeek.days + schedule.numeratorWeek.days
    }
    
    func setWeeks(weeks: [Week]) {
        for week in weeks {
            self.days.append(contentsOf: week.days)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    // Custom header for day title
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayHeader = tableView.dequeueReusableCell(withIdentifier: "DayHeader") as! DayHeader
        
        let day = days[section]
        
        dayHeader.titleLabel.text = day.title.rawValue.capitalized
        dayHeader.dateLabel.text = day.dateString
        
        return dayHeader
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days[section].lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        let lesson = days[indexPath.section].lessons[indexPath.row]
        
        // Set lesson info
        
        cell.titleLabel.text = lesson.title
        
        cell.teacherLabel.text = lesson.teacher
        cell.roomLabel.text = lesson.room
        cell.setType(type: lesson.type)
        
        cell.startTimeLabel.text = lesson.startTime
        cell.endTimeLabel.text = lesson.endTime
        
        // Set break info
        
        if indexPath.row > 0 { // Check if break exists before lesson
            let lastLesson = days[indexPath.section].lessons[indexPath.row - 1]
            
            if let breakTime = Manager.calendarManager.calculateBreakTime(lastLesson: lastLesson, lesson: lesson) {
                cell.breakLabel.text = "\(breakTime) минут перерыва"
            }
        } else {
            cell.breakLabel.text = ""
        }
        
        return cell
    }
    
    // MARK: -
    
    func changeSchedule() {
        
        //
        
    }

    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
