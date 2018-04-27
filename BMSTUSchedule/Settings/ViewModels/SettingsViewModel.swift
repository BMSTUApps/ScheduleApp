//
//  SettingsViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 27/04/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

enum SettingsSection: Int {
    case group, teachers, other
    
    // Group Row 👥
    enum GroupRow: Int {
        case group
        
        static var count = {
            return GroupRow.group.rawValue + 1
        }
        
        func canSelect() -> Bool {
            return false
        }
    }
    
    // Teachers Row 👨‍🏫
    enum TeachersRow: Int {
        case showAll
        
        static var count = {
            return TeachersRow.showAll.rawValue + 1
        }
        
        private static let titles = [showAll: "Show all teachers".localized]
        
        func title() -> String {
            if let title = TeachersRow.titles[self] {
                return title
            } else {
                return ""
            }
        }
        
        func canSelect() -> Bool {
            return false
        }
    }
    
    // Other Row 📖
    enum OtherRow: Int {
        case license, about
        
        static var count = {
            return OtherRow.about.rawValue + 1
        }
        
        private static let titles = [license: "License".localized,
                                       about: "About".localized]
        
        func title() -> String {
            if let title = OtherRow.titles[self] {
                return title
            } else {
                return ""
            }
        }
        
        private static let selections = [license: true,
                                           about: true]
        
        func canSelect() -> Bool {
            if let canSelect = OtherRow.selections[self] {
                return canSelect
            } else {
                return false
            }
        }
    }
    
    static var count = {
        return SettingsSection.other.rawValue + 1
    }
    
    private static let titles = [teachers: "Teachers".localized,
                                    other: "Other".localized]
    
    func title() -> String {
        if let title = SettingsSection.titles[self] {
            return title
        } else {
            return ""
        }
    }
}
