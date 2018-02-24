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
        layoutIfNeeded()
    }
    
    /// Get array of titles
    func getTitles() -> [String] {
        
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
    
    func drawTitles(titles: [String]) {
        
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
            
            // FIXME: Fix incorrect calculation
            let lineY = y + titleHeight / 2
            let lineX = bottomOffset + 26 + bottomOffset
            
            let lineView = UIView(frame: CGRect(x: CGFloat(lineX), y: CGFloat(lineY), width: self.frame.width - CGFloat(lineY), height: CGFloat(lineThickness)))
            self.addSubview(lineView)
            
            lineView.backgroundColor = UIColor(displayP3Red: 143/255, green: 142/255, blue: 148/255, alpha: 0.5)
            
            y += titleHeight + titleSpace
        }
    }
}
