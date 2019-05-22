//
//  GroupPickerController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 21/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

protocol GroupPickerControllerDelegate: AnyObject {
    func groupDidChoose(_ group: String)
}

class GroupPickerController: UIViewController {

    weak var delegate: GroupPickerControllerDelegate?
    
    @IBOutlet weak var picker: UIPickerView!
    
    // TODO: Get picker data from server
    private let pickerData: [String: [String: [String]]] = [
        "ИУ": [
            "4": ["11", "12", "13", "14"],
            "5": ["21Б", "22Б", "23Б", "24Б"]
        ],
        "МТ": [
            "1": ["31", "32", "33", "34"],
            "2": ["41", "42", "43", "44"]
        ],
    ]
    
    private enum Component: Int {
        case faculty = 0
        case department
        case group
        
        static var count: Int {
            return group.rawValue + 1
        }
    }
    
    var selectedGroup: String? {
        guard let faculty = selectedValue(for: .faculty),
            let department = selectedValue(for: .department),
            let group = selectedValue(for: .group) else {
                return nil
        }
        
        return "\(faculty)\(department)-\(group)"
    }
    
    private func selectedValue(for component: Component) -> String? {
        let row = picker.selectedRow(inComponent: component.rawValue)
        return pickerView(picker, titleForRow: row, forComponent: component.rawValue)
    }
    
    private func value(row: Int, for component: Component) -> String? {
        
        switch component {
        case .faculty:
            return pickerData.keys.sorted()[row]
        case .department:
            guard let selectedFaculty = selectedValue(for: .faculty),
                let departments = pickerData[selectedFaculty]?.keys.sorted() else {
                    return nil
            }
            
            return departments[row]
        case .group:
            guard let selectedFaculty = selectedValue(for: .faculty),
                let selectedDepartment = selectedValue(for: .department),
                let groups = pickerData[selectedFaculty]?[selectedDepartment]?.sorted() else {
                    return nil
            }
            
            return groups[row]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
    }

    @IBAction func chooseTapped(_ sender: UIButton) {
        guard let group = selectedGroup else {
                return
        }
        
        delegate?.groupDidChoose(group)
        dismiss(animated: true, completion: nil)
    }
}

extension GroupPickerController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Component.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let component = Component(rawValue: component) else { return 0 }
        
        switch component {
            
        case .faculty:
            return pickerData.count
            
        case .department:
            guard let faculty = selectedValue(for: .faculty),
                let count = pickerData[faculty]?.count else {
                    return 0
            }
            
            return count
            
        case .group:
            guard let faculty = selectedValue(for: .faculty),
                let department = selectedValue(for: .department),
                let count = pickerData[faculty]?[department]?.count else {
                    return 0
            }
            
            return count
        }
    }
}

extension GroupPickerController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let component = Component(rawValue: component) else { return nil }
        return value(row: row, for: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let component = Component(rawValue: component) else { return }
        
        switch component {
        case .faculty:
            pickerView.reloadComponent(Component.department.rawValue)
            pickerView.reloadComponent(Component.group.rawValue)
        case .department:
            pickerView.reloadComponent(Component.group.rawValue)
        case .group:
            break
        }
    }
}
