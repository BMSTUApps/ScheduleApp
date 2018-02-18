//
//  GroupsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 27/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class GroupsController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove empty cells
        tableView.tableFooterView = UIView()
        
        // Load groups
//        AppManager.firebase.getGroups { (groups: [Group]) in
//
//            // Set groups
//            self.groups = groups
//            self.tableView.reloadData()
//        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.selectionStyle = .none
        
        let group = self.groups[indexPath.row]
        
        // Set group info
        cell.nameLabel.text = group.name
        cell.courseLabel.text = String(format:"%d курс", group.course)

        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set new current group
        let group = self.groups[indexPath.row]
        AppManager.shared.currentGroup = group
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        // Deselect cell
    }
}
