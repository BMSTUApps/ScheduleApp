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
    let titleHeight = 15
    let titleSpace = 5
    let lineThickness = 0.5
    
    var selectedIndex: Int = 0
    var events: [Event] = [] {
        didSet {
            updateView()
        }
    }
    
    // FIXME: Create kind colors in Theme
    private let kindColors = [
        "lecture": AppTheme.shared.greenColor,
        "seminar": AppTheme.shared.blueColor,
        "lab"    : AppTheme.shared.yellowColor,
        "other"  : UIColor.gray
    ]
    
    private typealias Time = (hours: Int, minutes: Int)
    
    private var firstTime: Time? {
        return self.getTime(string: events.first?.startTime)
    }
    
    private var lastTime: Time? {
        return self.getTime(string: events.last?.endTime)
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
        drawEvents(events: events)
        layoutIfNeeded()
    }
    
    /// Get array of titles
    private func getTitles() -> [String] {
        
        if let firstTime = events.first?.startTime, let lastTime = events.last?.endTime {
            
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
        
        var lastLineView: UIView?
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
            lineView.translatesAutoresizingMaskIntoConstraints = false

            // Add constraints
            
            NSLayoutConstraint(item: lineView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: lineView.frame.origin.x).isActive = true
            NSLayoutConstraint(item: lineView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: lineView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: lineView.frame.height).isActive = true
            
            if let lastView = lastLineView {
                let viewY = lineView.frame.origin.y - lastView.frame.origin.y - lastView.frame.height
                NSLayoutConstraint(item: lineView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: lastView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: viewY).isActive = true
            } else {
                NSLayoutConstraint(item: lineView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: lineView.frame.origin.y).isActive = true
            }
            
            lastLineView = lineView
            y += titleHeight + titleSpace
        }
    }
    
    /// Draw events
    private func drawEvents(events: [Event]) {
    
        guard let firstTime = firstTime else { return }
        let firstTimeValue = CGFloat(firstTime.hours * 60)
        
        let topOffset = CGFloat(self.topOffset + titleHeight / 2)
        let bottomOfset = CGFloat(bottomOffset + 26 + bottomOffset)
        
        var lastEventView: UIView?
        for (index, event) in events.enumerated() {
            
            // Calculate frame
            
            guard let startTime = getTime(string: event.startTime) else { return }
            guard let endTime = getTime(string: event.endTime) else { return }
            
            let startTimeValue = CGFloat(startTime.hours * 60 + startTime.minutes)
            let endTimeValue = CGFloat(endTime.hours * 60 + endTime.minutes)

            let x = bottomOfset
            let y = topOffset + (startTimeValue - firstTimeValue) * CGFloat(titleHeight + titleSpace) / 60
            let width = self.frame.width - x
            let height = (endTimeValue - startTimeValue) * CGFloat(titleHeight + titleSpace) / 60
            
            let frame = CGRect(x: x, y: y, width: width, height: height)
            
            let view = UIView()
            self.addSubview(view)
            
            // Add title
            
            let titleLabel = UILabel()
            view.addSubview(titleLabel)
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.systemFont(ofSize: 11)
            titleLabel.textColor = UIColor.white
            titleLabel.numberOfLines = 0
            titleLabel.text = event.title
            NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 6).isActive = true
            NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 2).isActive = true
            
            // Add location
            
            let roomLabel = UILabel()
            view.addSubview(roomLabel)
            
            roomLabel.translatesAutoresizingMaskIntoConstraints = false
            roomLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            roomLabel.textColor = UIColor.white
            roomLabel.numberOfLines = 0
            roomLabel.text = event.location
            NSLayoutConstraint(item: roomLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 10).isActive = true
            NSLayoutConstraint(item: roomLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 1).isActive = true
            
            // Add constraints
            
            view.frame = frame
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: frame.origin.x).isActive = true
            NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: frame.height).isActive = true
            
            if let lastView = lastEventView {
                let viewY = frame.origin.y - lastView.frame.origin.y - lastView.frame.height
                NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: lastView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: viewY).isActive = true
            } else {
                NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: frame.origin.y).isActive = true
            }
            
            if selectedIndex == index {
                view.backgroundColor = kindColors[event.kind.rawValue]?.withAlphaComponent(0.8)
            } else {
                view.backgroundColor = kindColors[event.kind.rawValue]?.withAlphaComponent(0.5)
            }
            
            lastEventView = view
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
