//
//  TeachersController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 21/04/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeachersController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - UI
    
    func prepareUI() {
        
        // Set title
        self.navigationItem.title = "Teachers".localized
        
        // Set content inset
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        // Setup navigation bar
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = AppTheme.shared.navigationBarTintColor
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = String(describing: TeacherCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TeacherCell) ?? TeacherCell()

        // FIXME: Add view model
        let teacher = Teacher(firstName: "Манас", lastName: "Абулкасимов", department: "ИУ5")
        teacher.middleName = "Мукитович"
        teacher.position = "старший преподаватель"
        teacher.degree = "доцент"
        
        cell.fill(teacher: teacher)
        
        return cell
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTeacherController" {
            
            guard let teacherController = segue.destination as? TeacherController else {
                return
            }

            // FIXME: Find right view model
            let teacher = Teacher(firstName: "Манас", lastName: "Абулкасимов", department: "ИУ5")
            teacher.middleName = "Мукитович"
            teacher.position = "старший преподаватель"
            teacher.degree = "доцент"
            
            teacherController.teacher = teacher
        }
    }
}
