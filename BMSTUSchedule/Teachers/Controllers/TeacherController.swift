//
//  TeacherController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 03/05/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class TeacherController: UITableViewController {

    var teacher: Teacher?
    
    private var viewModel: TeacherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        updateTable()
    }
    
    func prepareUI() {
        
        // Set title
        self.navigationItem.title = "Teacher".localized
        
        // Set tableview
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }
    
    func updateTable() {
        
        guard let teacher = teacher else {
            return
        }
        
        viewModel = TeacherViewModel(teacher)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellViewModel = viewModel?.viewModel(for: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath)
        
        if let castedCell = cell as? CellViewModelProtocol {
            castedCell.fillCell(model: cellViewModel)
        }
        
        return cell
    }
}
