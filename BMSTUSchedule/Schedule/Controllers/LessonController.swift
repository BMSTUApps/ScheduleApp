//
//  LessonController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonController: UITableViewController {

    var lesson: Lesson?
    var displayedLessons: [Lesson]?
    
    private var viewModel: LessonViewModel?

    override var previewActionItems: [UIPreviewActionItem] {
        
        let notificationAction = UIPreviewAction(title: "Enable notifications".localized, style: .default, handler: { previewAction, viewController in
            // TODO: Setup notifications
        })
        
        return [notificationAction]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        updateTable()
    }
    
    func prepareUI() {
        
        self.navigationItem.title = "Lesson".localized
        
        // Hide large titles
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    func updateTable() {
        
        guard let lesson = lesson else {
            return
        }
        
        viewModel = LessonViewModel(lesson, displayedLessons: displayedLessons)
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
