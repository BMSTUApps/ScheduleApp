//
//  GroupsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 27/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var groups: [Group] = []
    var currentGroupIndexPath: IndexPath?
    
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
        
        // Load groups
        Manager.firebaseManager.getGroups { (groups: [Group]) in
            
            // Set groups
            self.groups = groups
            self.tableView.reloadData()
            
            // Select current group
            if let indexPath = self.currentGroupIndexPath, let cell = self.tableView.cellForRow(at: indexPath) {
                cell.setSelected(true, animated: false)
                cell.contentView.backgroundColor = UIColor(red: 241/255, green: 251/255, blue: 255/255, alpha: 1)
            }
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
        
        let group = self.groups[indexPath.row]
        
        // Save current group
        if let currentGroup = Manager.manager.currentGroup {
            if group == currentGroup {
                cell.setSelected(true, animated: false)
                cell.contentView.backgroundColor = UIColor(red: 241/255, green: 251/255, blue: 255/255, alpha: 1)
            }
        }
        
        // Set group info
        cell.nameLabel.text = group.name
        cell.courseLabel.text = String(format:"%d курс", group.course)
        
        // Set background view
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 233/255, alpha: 1)
        cell.selectedBackgroundView = backgroundView
 
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Set new current group
        let group = self.groups[indexPath.row]
        Manager.manager.currentGroup = group
        
        // Set custom selection color
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        UIView.animate(withDuration: 0.6, animations: {
            selectedCell.contentView.backgroundColor = UIColor(red: 232/255, green: 255/255, blue: 239/255, alpha: 1)
            selectedCell.contentView.backgroundColor = UIColor(red: 241/255, green: 251/255, blue: 255/255, alpha: 1)
        })
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        // Set custom deselection color
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        UIView.animate(withDuration: 0.6, animations: {
            selectedCell.contentView.backgroundColor = UIColor.white
        })
        
    }
    

    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
