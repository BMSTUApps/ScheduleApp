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

        self.navigationItem.title = lesson.title
    }
}
