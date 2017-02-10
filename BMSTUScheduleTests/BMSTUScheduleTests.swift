//
//  BMSTUScheduleTests.swift
//  BMSTUScheduleTests
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import XCTest
@testable import BMSTUSchedule

class BMSTUScheduleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK - CalendarModule
    
    func testWeeksFromSchedule() {
        
        let count = 3
        
        let schedule = Manager.standard.randomSchedule()
        let weeks = Manager.calendar.createWeeksFromSchedule(schedule: schedule, offset: 0, count: count)
        
        XCTAssert(weeks.count == count, "The week's count should be equal to count")
    }
    
}
