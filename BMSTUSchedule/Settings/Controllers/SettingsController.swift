//
//  SettingsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsController: TableViewController {

    private enum Section: Int {
        case group, teachers, other
        
        // Group Row 👥
        enum GroupRow: Int {
            case name, change
            
            static var count = {
                return GroupRow.change.rawValue + 1
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
        }
        
        static var count = {
            return Section.other.rawValue + 1
        }
        
        private static let titles = [teachers: "Teachers".localized,
                                     other: "Other".localized]
        
        func title() -> String {
            if let title = Section.titles[self] {
                return title
            } else {
                return ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - UI
    
    func prepareUI() {
        
        // Set title
        self.navigationItem.title = "Settings".localized
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return Section.count()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }

        return section.title()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        var rows = 0
        
        switch section {
        case .group:
            rows = Section.GroupRow.count()
        case .teachers:
            rows = Section.TeachersRow.count()
        case .other:
            rows = Section.OtherRow.count()
        }
        
        return rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return SettingsRowCell() }

        switch section {
        case .group:
            return cellForGroupSection(row: indexPath.row)
        case .teachers:
            return cellForTeachersSection(row: indexPath.row)
        case .other:
            return cellForOtherSection(row: indexPath.row)
        }
    }
    
    private func cellForGroupSection(row: Int) -> UITableViewCell {
    
        // ..
        
        return SettingsRowCell()
    }

    private func cellForTeachersSection(row: Int) -> UITableViewCell {
        guard let row = Section.TeachersRow(rawValue: row) else { return SettingsRowCell() }
        
        let reuseIdentifier = String(describing: SettingsRowCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SettingsRowCell) ?? SettingsRowCell()
        
        cell.fill(title: row.title(), style: .switcher)
        
        return cell
    }

    private func cellForOtherSection(row: Int) -> UITableViewCell {
        guard let row = Section.OtherRow(rawValue: row) else { return SettingsRowCell() }
        
        let reuseIdentifier = String(describing: SettingsRowCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SettingsRowCell) ?? SettingsRowCell()
        
        cell.fill(title: row.title(), style: .disclosure)
        
        return cell
    }
}
