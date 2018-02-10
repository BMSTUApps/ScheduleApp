//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit
import Firebase

class ScheduleController: TableViewController {
    
    var schedule: Schedule = Schedule()
    var group: Group?
    
    /// Return all days of 2 weeks
    var days: [Day] {
        return schedule.numeratorWeek.days + schedule.denominatorWeek.days
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // FIXME: Test schedule
        
        let lesson1 = Lesson(title: "Операционные системы", teacher: "Семкин П.С.", room: "515ю", kind: .lecture, startTime: "8:30", endTime: "10:15")
        let lesson2 = Lesson(title: "Теория вероятности и математическая статистика", teacher: "Безверхний Н.В.", room: "218л", kind: .seminar, startTime: "10:25", endTime: "11:50")
        let day = Day(title: .monday, lessons: [lesson1, lesson2, lesson1])
        let week = Week(kind: .denominator, days: [day, day, day, day, day])
        self.schedule = Schedule(numeratorWeek: week, denominatorWeek: week)
        
        prepareUI()
    }
    
    func prepareUI() {
        
        self.navigationItem.title = "Расписание"
        
        // Add large titles
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.barStyle = .black
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // Set table view
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = 40.0 // FIXME: Need self-size header
        tableView.rowHeight = 96.0 // FIXME: Need self-size cell
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier: String(describing: DayHeader.self))
        if let header = header as? DayHeader {
            
            let day = days[section]
            
            header.titleLabel.text = day.title.rawValue.capitalized
            header.dateLabel.text = day.dateString
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days[section].lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LessonCell.self), for: indexPath)
        if let cell = cell as? LessonCell {
            
            let lesson = days[indexPath.section].lessons[indexPath.row]
            
            cell.titleLabel.text = lesson.title
            
            cell.teacherLabel.text = lesson.teacher
            cell.roomLabel.text = lesson.room
            cell.setKind(kind: lesson.kind)
            
            cell.startTimeLabel.text = lesson.startTime
            cell.endTimeLabel.text = lesson.endTime
        }

        return cell
    }
}
