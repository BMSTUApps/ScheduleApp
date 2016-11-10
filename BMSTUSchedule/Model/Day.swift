//
//  Day.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 29/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

class Day: Base {

    var title: String
    var lessons: [Lesson]
    
    init(title: String, lessons: [Lesson]) {
        self.title = title
        self.lessons = lessons
    }
    
}
