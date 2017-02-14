//
//  MenuController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 02/11/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//
// DEPRECATED

import UIKit

class MenuController: UITableViewController {

    let menuItemSelectedColor = UIColor(red: 87/255, green: 108/255, blue: 126/255, alpha: 1)

    @IBOutlet var imageViews: [UIImageView]!
    
    @IBOutlet weak var currentGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set swipe menu
        self.revealViewController().rearViewRevealOverdraw = 0
        
        // Change default image's tint color
        for imageView: UIImageView in self.imageViews {
            let color = UIColor(red: 161/255, green: 172/255, blue: 182/255, alpha: 1)
            imageView.image = imageView.image?.imageWithColor(newColor: color)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Show current group
        self.currentGroupLabel.text = Manager.standard.currentGroup?.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        
        selectedCell.selectionStyle = .gray
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = menuItemSelectedColor
        selectedCell.selectedBackgroundView = backgroundView
        
        return true
    }
}
