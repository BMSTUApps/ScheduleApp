//
//  LessonController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/05/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class LessonController: TableViewController {

    var lesson: Lesson?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var kindView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        updateUI()
    }
    
    func prepareUI() {

        self.navigationItem.title = "Занятие"
        
        // Hide large titles
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        self.kindView.layer.cornerRadius = 10
    }
    
    func updateUI() {
        
        guard let castedLesson = lesson else {
            return
        }
        
        self.titleLabel.text = castedLesson.title
        self.kindLabel.text = castedLesson.kind.rawValue
    }
}
