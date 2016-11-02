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
    
    var schedule: Schedule = Schedule()
    
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
        
        // Set random schedule
        self.setRandomSchedule()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return schedule.numeratorWeek.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return schedule.numeratorWeek[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.numeratorWeek[section].lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        let lesson = schedule.numeratorWeek[indexPath.section].lessons[indexPath.row]
        
        cell.titleLabel.text = lesson.title
        
        cell.teacherLabel.text = lesson.teacher
        cell.roomLabel.text = lesson.room
        cell.typeLabel.text = lesson.typeString()
        
        cell.startTimeLabel.text = lesson.startTime
        cell.endTimeLabel.text = lesson.endTime
        
        if let type = lesson.type {
            cell.setTypeColor(type: type)
            cell.drawTypeRect(type: type)
        }
        
        return cell
    }
    
    func setRandomSchedule() {
     
        var daysTitles = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
        
        for i in 0...daysTitles.count-1 {
            
            let dayLessonsCount = arc4random_uniform(5) + 1
            var dayLessons: [Lesson] = []
            
            for _ in 0...dayLessonsCount {
                
                let lessonIndex = arc4random_uniform(3) + 1
                switch lessonIndex {
                case 1:
                    dayLessons.append(Lesson(title: "Теория вероятности",
                                             teacher: "Безверхний Н.В.",
                                             room: "230л",
                                             type: .lecture,
                                             startTime: "12:00",
                                             endTime: "13:35"))
                case 2:
                    dayLessons.append(Lesson(title: "Электротехника",
                                             teacher: "Белодедов М.В.",
                                             room: "700",
                                             type: .lab,
                                             startTime: "13:50",
                                             endTime: "15:25"))
                case 3:
                    dayLessons.append(Lesson(title: "Архитектура автоматизированных систем обработки информации и управления",
                                             teacher: "Шук В. П.",
                                             room: "501ю",
                                             type: .seminar,
                                             startTime: "10:15",
                                             endTime: "11:50"))
                default:
                    break
                }
                
            }
            
            let day = Day(title:daysTitles[i], lessons:dayLessons)
            self.schedule.numeratorWeek.append(day)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
