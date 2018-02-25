//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class ScheduleController: TableViewController {
    
    var schedule: Schedule? {
        
        didSet {
            
            // Set days
            var days: [Day] = []
            for week in (schedule?.weeks)! {
                days.append(contentsOf: week.days)
            }
            
            self.days = days
            
            // Set viewModels
            var daysViewModels: [DayViewModel] = []
            for day in days {
                let dayViewModel = DayViewModel(day)
                daysViewModels.append(dayViewModel)
            }
            
            self.daysViewModels = daysViewModels
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var group: Group?
    var days: [Day] = [] // FIXME: Remove days
    var daysViewModels: [DayViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        self.schedule = AppManager.shared.getCurrentSchedule()
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
        return daysViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier: String(describing: DayHeader.self))
        if let header = header as? DayHeader {
            
            let dayViewModel = daysViewModels[section]
            
            header.titleLabel.text = dayViewModel.title.localized.capitalized
            header.dateLabel.text = ""
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysViewModels[section].lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LessonCell.self), for: indexPath)
        if let cell = cell as? LessonCell {
            
            let lessonViewModel = daysViewModels[indexPath.section].lessons[indexPath.row]
            cell.fill(model: lessonViewModel)
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
            
            let startIndex = (indexPath.row - 1 >= 0) ? (indexPath.row - 1) : 0
            let endIndex = (indexPath.row + 1 < days[indexPath.section].lessons.count) ? (indexPath.row + 1) : days[indexPath.section].lessons.count-1
            let displayedLessons: [Lesson] = Array(days[indexPath.section].lessons[startIndex...endIndex])
            
            lessonController.lesson = days[indexPath.section].lessons[indexPath.row]
            lessonController.displayedLessons = displayedLessons        }
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
        
        let startIndex = (indexPath.row - 1 >= 0) ? (indexPath.row - 1) : 0
        let endIndex = (indexPath.row + 1 < days[indexPath.section].lessons.count) ? (indexPath.row + 1) : days[indexPath.section].lessons.count-1
        let displayedLessons: [Lesson] = Array(days[indexPath.section].lessons[startIndex...endIndex])
        
        lessonController.lesson = days[indexPath.section].lessons[indexPath.row]
        lessonController.displayedLessons = displayedLessons
        lessonController.preferredContentSize = CGSize(width: lessonController.preferredContentSize.width, height: 400)

        previewingContext.sourceRect = cell.frame
        
        return lessonController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
}
