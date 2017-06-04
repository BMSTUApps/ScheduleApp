//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit
import Firebase

class ScheduleController: UITableViewController {
    
    var schedule: Schedule?
    var group: Group?
    
    private var days: [Day] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view
        tableView.tableFooterView = UIView()
        self.tableView.sectionHeaderHeight = 40
        
        // Load group & schedule
        if let defaultGroup = Manager.standard.currentGroup {
            self.group = defaultGroup
            self.loadSchedule(group: self.group!)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
                
        // Check group
        if let defaultsGroup = Manager.standard.currentGroup {
            if let currentGroup = self.group {
                if currentGroup.name != defaultsGroup.name {
                    
                    self.group = defaultsGroup
                    
                    // Update schedule
                    self.loadSchedule(group: self.group!)
                }
            } else {
                self.group = defaultsGroup
            }
        }
    }
    
    // MARK: - Set table view
    
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
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let day = days[section]
        
        let dayHeader = tableView.dequeueReusableCell(withIdentifier: "DayHeader") as! DayHeader
            
        // Set day information
            
        dayHeader.titleLabel.text = day.title.rawValue.capitalized
        dayHeader.dateLabel.text = day.dateString
        
        // Check if today
        
        let currentDate = Manager.calendar.currentDate
        let currentDateString = Day.dateFormatter.string(from: currentDate)
        
        if currentDateString == day.dateString {
            dayHeader.today = true
        } else {
            dayHeader.today = false
        }
        
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
            
            if let breakTime = Manager.calendar.calculateBreakTime(lastLesson: lastLesson, lesson: lesson) {
                cell.breakLabel.text = "\(breakTime) минут перерыва"
            }
        } else {
            cell.breakLabel.text = ""
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // open lesson controller
        
    }
    
    // MARK: - Actions

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake { // After shaking the device
            _ = self.scrollToToday(animated: true)
        }
    }
    
    // MARK: - Schedule
    
    func loadSchedule(group: Group) {
        Manager.firebase.getSchedule(group: group, success: { schedule in
            // Save schedule
            self.schedule = schedule
            
            // Get weeks from schedule
            let weeks = Manager.calendar.createWeeksFromSchedule(schedule: schedule, offset: 0, count: 2)
            self.setWeeks(weeks: weeks)
            self.tableView.reloadData()
        })
    }
    
    // MARK: -
    
    func scrollToToday(animated: Bool) -> Bool {
       
        var indexPath: NSIndexPath?
        
        // Search current day
        
        let currentDate = Manager.calendar.currentDate
        let currentDateString = Day.dateFormatter.string(from: currentDate)
        
        for (index, day) in self.days.enumerated() {
            if currentDateString == day.dateString {
                indexPath = NSIndexPath(row: 0, section: index)
            }
        }
        
        // Scroll to section
        
        var success: Bool = false
        
        if indexPath != nil {
            self.tableView.scrollToRow(at: indexPath! as IndexPath, at: UITableViewScrollPosition.top, animated: animated)
            success = true
        } else {
            success = false
        }
        
        return success
    }
}
