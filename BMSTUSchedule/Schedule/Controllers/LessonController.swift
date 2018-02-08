//
//  LessonController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/05/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class LessonController: ViewController {

    var lesson = Lesson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearance()
        setTitle()
    }
    
    func setTitle() {
        
        var typeString = lesson.kind?.rawValue.capitalized
        
        if typeString == nil {
            typeString = "Занятие"
        }
        
        self.navigationItem.title = typeString
    }
}
