//
//  BSClass.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class Lesson {

    enum LessonType {
        case lecture
        case seminar
        case lab
        case consultation
    }
    
    var title: String
    
    var teacher: String?
    var room: String?
    
    var type: LessonType?
    
    public init(title: String) {
        self.title = title
    }
    
}
