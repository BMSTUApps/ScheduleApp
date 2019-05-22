//
//  EventActionsCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit
import SPStorkController

class EventActionsCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        notifyButton.layer.cornerRadius = 10.0
        editButton.layer.cornerRadius = 10.0
    }

    @IBAction func notifyButtonTapped(_ sender: Any) {
        print("Notify button tapped")
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        print("Edit button tapped")
        
        let transitionDelegate = SPStorkTransitioningDelegate()
        
        guard let controller = AppRouter.ModuleStoryboard.schedule.storyboard.instantiateViewController(withIdentifier: String(describing: EditEventController.self)) as? EditEventController,
            let rootController = AppManager.shared.router.topViewController() else {
            return
        }
        
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        
        rootController.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard model is EventActionsCellViewModel else {
            return
        }
        
        return
    }
}
