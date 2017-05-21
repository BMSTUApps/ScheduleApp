//
//  GroupsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 27/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove empty cells
        tableView.tableFooterView = UIView()
        
        // Load groups
        Manager.firebase.getGroups { (groups: [Group]) in
            
            // Set groups
            self.groups = groups
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.selectionStyle = .none
        
        let group = self.groups[indexPath.row]
        
        // Save current group
        if let currentGroup = Manager.standard.currentGroup {
            if group == currentGroup {
                // Select cell
            }
        }
        
        // Set group info
        cell.nameLabel.text = group.name
        cell.courseLabel.text = String(format:"%d курс", group.course)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set new current group
        let group = self.groups[indexPath.row]
        Manager.standard.currentGroup = group
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        // Deselect cell
    }
    

    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
