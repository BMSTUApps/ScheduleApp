//
//  EventController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventController: UITableViewController {

    var event: Event?
    var displayedEvents: [Event]?
    
    private var viewModel: EventViewModel?

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
        
        self.navigationItem.title = "Event".localized
        
        // Hide large titles
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    func updateTable() {
        
        guard let event = event else {
            return
        }
        
        viewModel = EventViewModel(event, displayedEvents: displayedEvents)
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
