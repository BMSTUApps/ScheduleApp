//
//  EventCalendarCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventCalendarCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var calendarView: CalendarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? EventCalendarCellViewModel else {
            return
        }

        calendarView.selectedIndex = castedModel.displayedEvents.index { (currentEvent) -> Bool in
            return currentEvent.startTime == castedModel.currentEvent.startTime
        }!
        calendarView.events = castedModel.displayedEvents
    }
}
