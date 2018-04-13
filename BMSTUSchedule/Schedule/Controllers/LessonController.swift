//
//  LessonController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/05/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class LessonController: ViewController {

    var lesson: Lesson?
    var displayedLessons: [Lesson]?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var kindView: UIView!
    
    @IBOutlet weak var teacherTitleLabel: UILabel!
    @IBOutlet weak var teacherValueLabel: UILabel!
    @IBOutlet weak var roomTitleLabel: UILabel!
    @IBOutlet weak var roomValueLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    
    @IBOutlet weak var calendarView: CalendarView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override var previewActionItems: [UIPreviewActionItem] {
        
        let notificationAction = UIPreviewAction(title: "Enable notifications".localized, style: .default, handler: { previewAction, viewController in
            // TODO: Setup notifications
        })

        return [notificationAction]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        updateUI()
    }
    
    func prepareUI() {

        self.navigationItem.title = "Lesson".localized
        self.scrollView.alwaysBounceVertical = true
        
        // Hide large titles
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        self.kindView.layer.cornerRadius = 10
        
        self.teacherTitleLabel.text = "\("Teacher".localized):"
        self.roomTitleLabel.text = "\("Room".localized):"
        self.timeTitleLabel.text = "\("Time".localized):"
    }
    
    func updateUI() {
        
        guard let castedLesson = lesson else {
            return
        }
        
        self.titleLabel.text = castedLesson.title
        self.kindLabel.text = castedLesson.kind.rawValue.localized

        switch castedLesson.kind {
        case .lecture:
            self.kindView.backgroundColor = AppTheme.shared.greenColor
        case .seminar:
            self.kindView.backgroundColor = AppTheme.shared.blueColor
        case .lab:
            self.kindView.backgroundColor = AppTheme.shared.yellowColor
        default:
            self.kindView.backgroundColor = UIColor.gray
        }
        
        self.teacherValueLabel.text = " \(castedLesson.teacher ?? "")"
        self.roomValueLabel.text = " \(castedLesson.room ?? "")"
        self.timeValueLabel.text = " \(castedLesson.startTime) - \(castedLesson.endTime)"
        
        guard let lesson = self.lesson, let displayedLessons = displayedLessons else { return }
        self.calendarView.selectedIndex = displayedLessons.index { (currentLesson) -> Bool in
            return currentLesson.startTime == lesson.startTime
        }!
        self.calendarView.lessons = displayedLessons
    }
}
