//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class ScheduleController: TableViewController {
    
    let scheduleStream = ScheduleStream(events: AppManager.shared.getCurrentEvents())
    
    var events: [Event] = [] {
        didSet {
            scheduleViewModel = ScheduleViewModel(events: events)
            //tableView.reloadData()
        }
    }
    
    private var scheduleViewModel = ScheduleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        
        events = scheduleStream.get(.current)
    }
    
    private func prepareUI() {
        
        self.navigationItem.title = "Schedule".localized

        // Add large titles
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.barStyle = .black
            self.navigationController?.navigationBar.tintColor = AppTheme.shared.navigationBarTintColor
            self.navigationController?.view.backgroundColor = self.view.backgroundColor
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // Set table view
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = 40.0 // FIXME: Need self-size header
        tableView.estimatedRowHeight = 96.0 // FIXME: Need self-size cell
        
        // Setup 3d touch
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        } else {
            print("3D Touch Not Available")
        }
    }
    
    func loadNextWeek() {
        
        let newEvents = scheduleStream.get(.next)
        events.append(contentsOf: newEvents)
        
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return scheduleViewModel.daySectionViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier: String(describing: DayHeader.self))
        if let header = header as? DayHeader {
            
            let dayViewModel = scheduleViewModel.daySectionViewModels[section]
            
            header.titleLabel.text = dayViewModel.title.capitalized
            header.dateLabel.text = dayViewModel.subtitle
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleViewModel.daySectionViewModels[section].eventCellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath)
        if let cell = cell as? EventCell {
            
            let eventViewModel = scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels[indexPath.row]
            cell.fill(model: eventViewModel)
        }
        
        if indexPath.section == tableView.numberOfSections - 1 {
            loadNextWeek()
        }
        
        return cell
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowEventController" {
            
            guard let eventController = segue.destination as? EventController else {
                return
            }

            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            
            let startIndex = (indexPath.row - 1 >= 0) ? (indexPath.row - 1) : 0
            let endIndex = (indexPath.row + 1 < scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels.count) ? (indexPath.row + 1) : scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels.count-1
            
            let displayedEvents: [Event] = Array(scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels[startIndex...endIndex]).map { (eventCellViewModel) -> Event in
                return eventCellViewModel.event
            }
            
            eventController.event = scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels[indexPath.row].event
            eventController.displayedEvents = displayedEvents
        }
    }
}

extension ScheduleController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        
        guard let eventController = storyboard?.instantiateViewController(withIdentifier: String(describing: EventController.self)) as? EventController else {
            return nil
            
        }
        
        let startIndex = (indexPath.row - 1 >= 0) ? (indexPath.row - 1) : 0
        let endIndex = (indexPath.row + 1 < scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels.count) ? (indexPath.row + 1) : scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels.count-1
        
        let displayedEvents: [Event] = Array(scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels[startIndex...endIndex]).map { (eventCellViewModel) -> Event in
            return eventCellViewModel.event
        }
        
        eventController.event = scheduleViewModel.daySectionViewModels[indexPath.section].eventCellViewModels[indexPath.row].event
        eventController.displayedEvents = displayedEvents
        eventController.preferredContentSize = CGSize(width: eventController.preferredContentSize.width, height: 400)

        previewingContext.sourceRect = cell.frame
        
        return eventController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
