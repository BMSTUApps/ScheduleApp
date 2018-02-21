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
    
    var schedule: Schedule?
    var group: Group?
    
    var days: [Day] {
        
        var days: [Day] = []
        for week in (schedule?.weeks)! {
            days.append(contentsOf: week.days)
        }
        
        return days
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // FIXME: Test schedule
        
        let group = Group(name: "ИУ5-63")
        self.group = group
        
        let lesson1 = Lesson(title: "English", teacher: "Трошина О.В.", room: "401л", kind: .seminar, startTime: "8:30", endTime: "10:15")
        let lesson2 = Lesson(title: "Network Software", teacher: "Семкин П.С.", room: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let lesson3 = Lesson(title: "Multimedia Technology", teacher: "Афанасьев Г.И.", room: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let lesson4 = Lesson(title: "Philosophy", teacher: nil, room: "502", kind: .seminar, startTime: "13:50", endTime: "15:25")
        let lesson5 = Lesson(title: "Swimming pool", teacher: "Васющенкова Т.С.", room: "Sports Complex", kind: .undefined, startTime: "15:50", endTime: "17:25")

        let monday = Day(title: .monday, lessons: [lesson1, lesson2, lesson3, lesson4, lesson5], date: Date())
        
        let lesson6 = Lesson(title: "Discrete optimization methods", teacher: "Иванов А.О.", room: "306ю", kind: .seminar, startTime: "8:30", endTime: "10:15")
        let lesson7 = Lesson(title: "Discrete optimization methods", teacher: "Иванов А.О.", room: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let lesson8 = Lesson(title: "Description of the life cycle processes of ASOIS", teacher: "Черненький В. М.", room: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let lesson9 = Lesson(title: "Description of the life cycle processes of ASOIS", teacher: "Черненький В. М.", room: "515ю", kind: .lecture, startTime: "13:50", endTime: "15:25")
        let lesson10 = Lesson(title: "Swimming pool", teacher: "Васющенкова Т.С.", room: "Sports Complex", kind: .undefined, startTime: "15:50", endTime: "17:25")
        
        let numeratorTuesday = Day(title: .tuesday, lessons: [lesson6, lesson7, lesson8, lesson9, lesson10], date: Date())

        let lesson11 = Lesson(title: "Military Training", teacher: "Лясковский В.Л.", room: "214", kind: .seminar, startTime: "10:15", endTime: "11:50")
        let lesson12 = Lesson(title: "Military Training", teacher: "Горелов В.И", room: "214", kind: .seminar, startTime: "12:00", endTime: "13:35")
        let lesson13 = Lesson(title: "Military Training", teacher: "Амелько А.В.", room: "214", kind: .seminar, startTime: "13:50", endTime: "15:25")
        let lesson14 = Lesson(title: "Military Training", teacher: "Горелов В.И", room: "208", kind: .seminar, startTime: "15:40", endTime: "17:15")
        let lesson15 = Lesson(title: "Multimedia Technology", teacher: "Белоногов И.Б.", room: "903", kind: .lab, startTime: "17:25", endTime: "19:00")
        let lesson16 = Lesson(title: "Multimedia Technology", teacher: "Белоногов И.Б.", room: "903", kind: .lab, startTime: "19:10", endTime: "20:45")

        let numeratorWednesday = Day(title: .wednesday, lessons: [lesson11, lesson12, lesson13, lesson14, lesson15, lesson16], date: Date())

        let lesson17 = Lesson(title: "Network technologies in ASOIS", teacher: "Антонов А.И.", room: "515ю", kind: .lecture, startTime: "10:15", endTime: "11:50")
        let lesson18 = Lesson(title: "Philosophy", teacher: "Ивлев В.Ю.", room: "515ю", kind: .lecture, startTime: "12:00", endTime: "13:35")
        let lesson19 = Lesson(title: "Supercomputer", teacher: "Калистратов А.П.", room: "515ю", kind: .lecture, startTime: "13:50", endTime: "15:25")
        
        let numeratorThursday = Day(title: .thursday, lessons: [lesson17, lesson18, lesson19], date: Date())

        let lesson20 = Lesson(title: "Network Software", teacher: "Семкин П.С.", room: "903", kind: .lab, startTime: "8:30", endTime: "10:15")
        let lesson21 = Lesson(title: "Network Software", teacher: "Семкин П.С.", room: "903", kind: .lab, startTime: "10:15", endTime: "11:50")
        
        let numeratorSaturday = Day(title: .saturday, lessons: [lesson20, lesson21], date: Date())

        let lesson22 = Lesson(title: "Description of the life cycle processes of ASOIS", teacher: "Черненький М. В.", room: "395", kind: .seminar, startTime: "13:50", endTime: "15:25")

        let denominatorTuesday = Day(title: .tuesday, lessons: [lesson6, lesson7, lesson8, lesson22, lesson10], date: Date())

        let denominatorWednesday = Day(title: .wednesday, lessons: [lesson11, lesson12, lesson13, lesson14], date: Date())

        let lesson23 = Lesson(title: "Supercomputer", teacher: "Калистратов А.П.", room: "903", kind: .lab, startTime: "15:40", endTime: "17:15")
        
        let denominatorThursday = Day(title: .thursday, lessons: [lesson17, lesson18, lesson19, lesson23], date: Date())

        let lesson24 = Lesson(title: "Network technologies in ASOIS", teacher: "Аксёнов А.Н", room: "362", kind: .lab, startTime: "8:30", endTime: "10:15")
        let lesson25 = Lesson(title: "Network technologies in ASOIS", teacher: "Аксёнов А.Н", room: "362", kind: .lab, startTime: "10:15", endTime: "11:50")
        
        let denominatorFriday = Day(title: .friday, lessons: [lesson24, lesson25], date: Date())
        
        let numerator = Week(number: 0, kind: .numerator, days: [monday, numeratorTuesday, numeratorWednesday, numeratorThursday, numeratorSaturday])
        let denominator = Week(number: 0, kind: .denominator, days: [monday, denominatorTuesday, denominatorWednesday, denominatorThursday, denominatorFriday])

        self.schedule = Schedule(group: group, weeks: [numerator, denominator])
        
        prepareUI()
    }
    
    func prepareUI() {
        
        self.navigationItem.title = "Schedule".localized

        // Add large titles
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.barStyle = .black
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.view.backgroundColor = self.view.backgroundColor
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // Set table view
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = 40.0 // FIXME: Need self-size header
        tableView.estimatedRowHeight = 96.0 // FIXME: Need self-size cell
        
        // Setup 3d touch
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        } else {
            print("3D Touch Not Available")
        }
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
            header.dateLabel.text = ""
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
            let model = LessonViewModel(lesson)
            cell.fill(model: model)
        }

        return cell
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowLessonViewController" {
            
            guard let lessonController = segue.destination as? LessonController else {
                return
            }

            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            
            lessonController.lesson = days[indexPath.section].lessons[indexPath.row]
        }
    }
}

extension ScheduleController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        
        guard let lessonController = storyboard?.instantiateViewController(withIdentifier: String(describing: LessonController.self)) as? LessonController else {
            return nil
            
        }
        
        lessonController.lesson = days[indexPath.section].lessons[indexPath.row]
        lessonController.preferredContentSize = CGSize(width: lessonController.preferredContentSize.width, height: 350)

        previewingContext.sourceRect = cell.frame
        
        return lessonController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
}
