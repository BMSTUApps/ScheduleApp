//
//  CalendarView.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 23/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class CalendarView: UIView {

    let topOffset = 10
    let bottomOffset = 12
    let titleHeight = 12
    let titleSpace = 5
    let lineThickness = 0.5
    
    var selectedIndex: Int = 0
    var lessons: [Lesson] = [] {
        didSet {
            updateView()
        }
    }
    
    // FIXME: Create kind colors in Theme
    private let kindColors = [
        "lecture": AppTheme.current.greenColor,
        "seminar": AppTheme.current.blueColor,
        "lab"    : AppTheme.current.yellowColor,
        "other"  : UIColor.gray
    ]
    
    private typealias Time = (hours: Int, minutes: Int)
    
    private var firstTime: Time? {
        return self.getTime(string: lessons.first?.startTime)
    }
    
    private var lastTime: Time? {
        return self.getTime(string: lessons.last?.endTime)
    }
    
    override var intrinsicContentSize: CGSize {
        
        let titles = self.getTitles()
        
        let height = topOffset + (titles.count - 1) * (titleHeight + titleSpace) + titleHeight + topOffset
        let size = CGSize(width: self.frame.width, height: CGFloat(height))
        
        return size
    }
    
    override func awakeFromNib() {
        
        self.layer.borderWidth = CGFloat(lineThickness)
        self.layer.borderColor = UIColor(displayP3Red: 143/255, green: 142/255, blue: 148/255, alpha: 0.5).cgColor
    }
    
    func updateView() {
        let titles = getTitles()
        
        drawTitles(titles: titles)
        drawLessons(lessons: lessons)
        layoutIfNeeded()
    }
    
    /// Get array of titles
    private func getTitles() -> [String] {
        
        if let firstTime = lessons.first?.startTime, let lastTime = lessons.last?.endTime {
            
            guard let indexFirst = firstTime.index(of: ":") else { return [] }
            guard let indexLast = lastTime.index(of: ":") else { return [] }

            guard let firstHour = Int(firstTime.prefix(upTo: indexFirst)) else { return [] }
            guard let lastHour = Int(lastTime.prefix(upTo: indexLast)) else { return [] }

            var titles: [String] = []
            for hour in firstHour...lastHour+1 {
                titles.append("\(hour):00")
            }
            
            return titles
        }
        
        return []
    }
    
    /// Draw array of titles
    private func drawTitles(titles: [String]) {
        
        var y = topOffset
        
        for title in titles {
            
            // Draw label
            
            let label = UILabel()
            self.addSubview(label)
            
            label.frame = CGRect(x: bottomOffset, y: y, width: 100, height: 12)
            label.text = title
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = UIColor(displayP3Red: 143/255, green: 142/255, blue: 148/255, alpha: 1)
            
            // Draw line
            
            let lineY = y + titleHeight / 2
            let lineX = bottomOffset + 26 + bottomOffset
            
            let lineView = UIView(frame: CGRect(x: CGFloat(lineX), y: CGFloat(lineY), width: self.frame.width - CGFloat(lineX), height: CGFloat(lineThickness)))
            self.addSubview(lineView)
            
            lineView.backgroundColor = UIColor(displayP3Red: 143/255, green: 142/255, blue: 148/255, alpha: 0.5)
            
            y += titleHeight + titleSpace
        }
    }
    
    /// Draw lessons
    private func drawLessons(lessons: [Lesson]) {
    
        guard let firstTime = firstTime else { return }
        let firstTimeValue = CGFloat(firstTime.hours * 60)
        
        let topOffset = CGFloat(self.topOffset + titleHeight / 2)
        let bottomOfset = CGFloat(bottomOffset + 26 + bottomOffset)
        
        for lesson in lessons {
            
            guard let startTime = getTime(string: lesson.startTime) else { return }
            guard let endTime = getTime(string: lesson.endTime) else { return }
            
            let startTimeValue = CGFloat(startTime.hours * 60 + startTime.minutes)
            let endTimeValue = CGFloat(endTime.hours * 60 + endTime.minutes)

            let x = bottomOfset
            let y = topOffset + (startTimeValue - firstTimeValue) * CGFloat(titleHeight + titleSpace) / 60
            let width = self.frame.width - x
            let height = (endTimeValue - startTimeValue) * CGFloat(titleHeight + titleSpace) / 60
            
            let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            view.backgroundColor = kindColors[lesson.kind.rawValue]?.withAlphaComponent(0.5)
            self.addSubview(view)
        }
    }
    
    // MARK: Helpers
    
    /// Get time tuple from string
    private func getTime(string: String?) -> Time? {
        
        guard let castedString = string else { return nil }
        guard let index = castedString.index(of: ":") else { return nil }
        guard let hours = Int(castedString.prefix(upTo: index)) else { return nil }
        guard let minutes = Int(castedString.suffix(from: castedString.index(after: index))) else { return nil }

        return (hours, minutes)
    }
}
