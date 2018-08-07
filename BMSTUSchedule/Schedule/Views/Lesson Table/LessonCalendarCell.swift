//
//  LessonCalendarCell.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class LessonCalendarCell: UITableViewCell, CellViewModelProtocol {

    @IBOutlet weak var calendarView: CalendarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - CellViewModelProtocol
    
    func fillCell(model: CellViewModel) {
        
        guard let castedModel = model as? LessonCalendarCellViewModel else {
            return
        }

        calendarView.selectedIndex = castedModel.displayedLessons.index { (currentLesson) -> Bool in
            return currentLesson.startTime == castedModel.currentLesson.startTime
        }!
        calendarView.lessons = castedModel.displayedLessons
    }
}
