//
//  SettingsController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 25/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit

class SettingsController: TableViewController {
    
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
        
        return SettingsSection.count()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSection(rawValue: section) else { return nil }

        return section.title()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        var rows = 0
        
        switch section {
        case .group:
            rows = SettingsSection.GroupRow.count()
        case .teachers:
            rows = SettingsSection.TeachersRow.count()
        case .other:
            rows = SettingsSection.OtherRow.count()
        }
        
        return rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return SettingsRowCell() }

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
        guard let row = SettingsSection.GroupRow(rawValue: row) else { return SettingsGroupCell() }
        
        let reuseIdentifier = String(describing: SettingsGroupCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SettingsGroupCell) ?? SettingsGroupCell()
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, UIScreen.main.bounds.width)
        cell.selectionStyle = row.canSelect() ? .default : .none
        
        // Fix group name
        cell.fill(groupName: "ИУ5-63")

        return cell
    }

    private func cellForTeachersSection(row: Int) -> UITableViewCell {
        guard let row = SettingsSection.TeachersRow(rawValue: row) else { return SettingsRowCell() }
        
        let reuseIdentifier = String(describing: SettingsRowCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SettingsRowCell) ?? SettingsRowCell()
        
        cell.selectionStyle = row.canSelect() ? .default : .none
        cell.fill(title: row.title(), style: .switcher)
        
        return cell
    }

    private func cellForOtherSection(row: Int) -> UITableViewCell {
        guard let row = SettingsSection.OtherRow(rawValue: row) else { return SettingsRowCell() }
        
        let reuseIdentifier = String(describing: SettingsRowCell.self)
        let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SettingsRowCell) ?? SettingsRowCell()
        
        cell.selectionStyle = row.canSelect() ? .default : .none
        cell.fill(title: row.title(), style: .disclosure)
        
        return cell
    }
}
