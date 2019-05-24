//
//  EventController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit
import SPStorkController

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
    
    // MARK: - UITableViewDataSource

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
        
        if let castedCell = cell as? TableCell {
            castedCell.delegate = self
        }
        
        if let castedCell = cell as? CellViewModelProtocol {
            castedCell.fillCell(model: cellViewModel)
        }

        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return viewModel?.viewModel(for: indexPath)?.shouldHighlight ?? false
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTeacherController" {
            
            guard let teacherController = segue.destination as? TeacherController else {
                return
            }

            teacherController.teacher = event?.teacher
        }
    }
}

extension EventController: EventActionsCellDelegate {
    
    func onNotify() {
        print("onNotify")
        
        let alert = UIAlertController(title: "Напоминание установлено", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func onEdit() {
        print("onEdit")
        
        let transitionDelegate = SPStorkTransitioningDelegate()
        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: String(describing: EditEventController.self)) as? EditEventController else {
                return
        }
        
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        
        present(controller, animated: true, completion: nil)
    }
}
