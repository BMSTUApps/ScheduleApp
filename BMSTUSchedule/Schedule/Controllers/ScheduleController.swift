//
//  ScheduleController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class ScheduleController: TableViewController {
    
    let scheduleStream = ScheduleStream(events: AppManager.shared.getEvents())
    
    var events: [Event] = [] {
        didSet {
            scheduleViewModel = ScheduleViewModel(events: events, startTermWeekIndex: scheduleStream.startTermWeekIndex)
            //tableView.reloadData()
        }
    }
    
    private var scheduleViewModel = ScheduleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        setupIntents()
        
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
    
    func eventsAround(at indexPath: IndexPath) -> [Event] {
        
        let startIndex = (indexPath.row - 1 >= 0) ? (indexPath.row - 1) : 0
        let endIndex = (indexPath.row + 1 < scheduleViewModel.sections[indexPath.section].cells.count) ? (indexPath.row + 1) : scheduleViewModel.sections[indexPath.section].cells.count-1
        
        let displayedModels = Array(scheduleViewModel.sections[indexPath.section].cells[startIndex...endIndex])
        
        var displayedEvents: [Event] = []
        for model in displayedModels {
            if let eventModel = model as? EventCellViewModel {
                displayedEvents.append(eventModel.event)
            }
        }
        
        return displayedEvents
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("Begin Dragging")
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom
        let h = scrollView.contentSize.height
        let reloadDistance: CGFloat = 200
        
        if y > (h + reloadDistance) {
            print("Did Scroll")
            loadNextWeek()
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return scheduleViewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (scheduleViewModel.sections[section].header != nil) ? 40 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerModel = scheduleViewModel.sections[section].header,
              let headerCell = tableView.dequeueReusableCell(withIdentifier: headerModel.identifier) else {
            return nil
        }

        if let castedCell = headerCell as? CellViewModelProtocol {
            castedCell.fillCell(model: headerModel)
        }
        
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleViewModel.sections[section].cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellViewModel = scheduleViewModel.viewModel(for: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath)
        
        if let castedCell = cell as? CellViewModelProtocol {
            castedCell.fillCell(model: cellViewModel)
        }
        
        return cell
    }
    
    // MARK: UITableViewDelega

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return scheduleViewModel.viewModel(for: indexPath)?.shouldHighlight ?? false
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
            
            if let eventCellViewModel = scheduleViewModel.viewModel(for: indexPath) as? EventCellViewModel {
                eventController.event = eventCellViewModel.event
            }
            
            eventController.displayedEvents = eventsAround(at: indexPath)
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
        
        if let eventCellViewModel = scheduleViewModel.viewModel(for: indexPath) as? EventCellViewModel {
            eventController.event = eventCellViewModel.event
        }
        
        eventController.displayedEvents = eventsAround(at: indexPath)
        eventController.preferredContentSize = CGSize(width: eventController.preferredContentSize.width, height: 400)

        previewingContext.sourceRect = cell.frame
        
        return eventController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func setupIntents() {
        
        let activityIdentifier = "\(Bundle.main.bundleIdentifier!).\(AppManager.Action.openSchedule.rawValue)"
        let activity = NSUserActivity(activityType: activityIdentifier)
        activity.title = "Show schedule".localized
        activity.userInfo = ["speech" : "schedule"]
        activity.isEligibleForSearch = true
        
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.persistentIdentifier = NSUserActivityPersistentIdentifier(activityIdentifier)
        }
        
        view.userActivity = activity
        
        activity.becomeCurrent()
    }
}
