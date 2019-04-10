//
//  TeachersController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/04/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeachersController: UITableViewController {

    let teachers = AppManager.shared.getTeachers()
    
    private(set) var showTeachers: [Teacher] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        setupIntents()
        
        showTeachers = teachers
    }
    
    // MARK: - UI
    
    func prepareUI() {
        
        // Set title
        self.navigationItem.title = "Teachers".localized
        
        // Set tableview
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.keyboardDismissMode = .onDrag
        
        // Setup navigation bar
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = AppTheme.shared.navigationBarTintColor
        
        // Setup 3d touch
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        } else {
            print("3D Touch Not Available")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + showTeachers.count // search + teachers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row != 0 else {
            
            // Search Cell
            
            let reuseIdentifier = String(describing: TeacherSearchCell.self)
            let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TeacherSearchCell) ?? TeacherSearchCell()
            cell.searchBar.delegate = self

            return cell
        }
        
        // Teacher Cell
        
        let reuseIdentifier = String(describing: TeacherCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TeacherCell) ?? TeacherCell()
        
        cell.fill(teacher: showTeachers[indexPath.row - 1])
        
        return cell
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTeacherController" {
            
            guard let teacherController = segue.destination as? TeacherController else {
                return
            }

            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            
            teacherController.teacher = teachers[indexPath.row - 1]
        }
    }
}

extension TeachersController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) as? TeacherCell else {
            return nil
        }
        
        guard let teacherController = storyboard?.instantiateViewController(withIdentifier: String(describing: TeacherController.self)) as? TeacherController else {
            return nil
            
        }
        
        teacherController.teacher = self.teachers[indexPath.row - 1]
        teacherController.preferredContentSize = CGSize(width: teacherController.preferredContentSize.width, height: 400)
        
        previewingContext.sourceRect = cell.convert(cell.liningView.frame, to: self.view)
        
        return teacherController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func setupIntents() {
        
        let activityIdentifier = "\(Bundle.main.bundleIdentifier!).\(AppManager.Action.openTeachers.rawValue)"
        let activity = NSUserActivity(activityType: activityIdentifier)
        activity.title = "Show teachers".localized
        activity.userInfo = ["speech" : "teachers"]
        activity.isEligibleForSearch = true
        
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.persistentIdentifier = NSUserActivityPersistentIdentifier(activityIdentifier)
        }
        
        view.userActivity = activity
        
        activity.becomeCurrent()
    }
}

extension TeachersController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.isEmpty == false else {
            updateTeachers(with: self.teachers)
            return
        }
        
        let searchString = searchText.lowercased()
        
        let filteredTeachers = self.teachers.filter { teacher -> Bool in
            
            let firstName = teacher.firstName.lowercased()
            let lastName = teacher.lastName.lowercased()
            let middleName = teacher.middleName?.lowercased()
            
            return firstName.contains(searchString) || lastName.contains(searchString) || (middleName?.contains(searchString) ?? false)
        }
        
        updateTeachers(with: filteredTeachers)
    }
    
    func updateTeachers(with newTeachers: [Teacher]) {
        
        let animation: UITableView.RowAnimation = .fade
        
        self.tableView.beginUpdates()
        
        var oldIndexPaths: [IndexPath] = []
        for (index, _) in showTeachers.enumerated() {
            oldIndexPaths.append(IndexPath(row: index + 1, section: 0))
        }
        self.tableView.deleteRows(at: oldIndexPaths, with: animation)
        
        self.showTeachers = newTeachers

        var newIndexPaths: [IndexPath] = []
        for (index, _) in newTeachers.enumerated() {
            newIndexPaths.append(IndexPath(row: index + 1, section: 0))
        }
        self.tableView.insertRows(at: newIndexPaths, with: animation)
        
        self.tableView.endUpdates()
    }
}
