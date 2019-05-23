//
//  SignupController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit
import SPStorkController

class SignupController: UITableViewController {
    
    @IBOutlet private weak var emailField: RoundTextField!
    @IBOutlet private weak var passwordField: RoundTextField!
    @IBOutlet private weak var lastNameField: RoundTextField!
    @IBOutlet private weak var firstNameField: RoundTextField!
    @IBOutlet weak var groupField: RoundTextField!
    
    @IBOutlet private weak var nextButton: UIButton!

    private var group: String?
    
    private var emailValid: Bool {
        guard let text = emailField.text else { return false }
        return text.isEmail
    }
    
    private var passwordValid: Bool {
        guard let text = passwordField.text else { return false }
        return text.count > 8
    }
    
    private var lastNameValid: Bool {
        guard let text = lastNameField.text else { return false }
        return text.count > 3
    }
    
    private var firstNameValid: Bool {
        guard let text = firstNameField.text else { return false }
        return text.count > 3
    }
    
    private var groupValid: Bool {
        if let group = group, !group.isEmpty {
            return true
        }
        
        return false
    }
    
    private var dataValid: Bool {
        return emailValid && passwordValid && lastNameValid && firstNameValid && groupValid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        lastNameField.delegate = self
        firstNameField.delegate = self
        groupField.delegate = self
        
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lastNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        firstNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showGroupPicker))
        groupField.addGestureRecognizer(tap)
        
        updateNextButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGroupField()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // MARK: Actions
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // TODO: Sign up
    }
    
    // MARK: UI
    
    private func updateNextButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.nextButton.isEnabled = self.dataValid
            self.nextButton.backgroundColor = self.nextButton.isEnabled ? AppTheme.AppColor.blue : AppTheme.AppColor.lightGray
        }
    }
    
    private func updateGroupField() {
        groupField.text = group
    }
    
    @objc private func showGroupPicker() {
        ActivityIndicator.standart.start()
        view.endEditing(true)
        
        getPickerData { (data) in
            guard let data = data else { return }
        
            DispatchQueue.main.async {
                ActivityIndicator.standart.stop()
                self.openPickerController(data: data)
            }
        }
    }
    
    private func openPickerController(data: GroupPickerController.Data) {
        
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.customHeight = 300
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: GroupPickerController.self)) as? GroupPickerController else {
            return
        }
        
        controller.delegate = self
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        controller.pickerData = data
        
        self.present(controller, animated: true, completion: nil)
    }
    
    private func getPickerData(completion: @escaping (GroupPickerController.Data?) -> Void) {
        AppManager.shared.networkingService.makeRequest(module: .schedule, method: (.get, "templates")) { result in
            switch result {
            case .failure(let error):
                // TODO: Handle error
                break
            case .success(let json):
                guard let rawGroups = json["result"] as? [JSON] else {
                    completion(nil)
                    return
                }
                
                let groups = rawGroups.compactMap({ raw in
                    return Group(json: raw)
                }).sorted(by: { (first, second) -> Bool in
                    if first.department == second.department {
                        return first.number < second.number
                    }
                    
                    return first.department < second.department
                })
                
                var data = GroupPickerController.Data()
                for group in groups {
                    var departmentNumber = 1
                    if let number = Int(group.department.numerals) {
                        departmentNumber = number
                    }
                    
                    let faculty = group.department.replacingOccurrences(of: "\(departmentNumber)", with: "")
                    
                    var groupsArray = data[faculty]?["\(departmentNumber)"] ?? []
                    groupsArray.append((group.number, schedule: group.scheduleID))
                    
                    if data[faculty] == nil {
                        data[faculty] = ["\(departmentNumber)": groupsArray]
                    } else {
                        data[faculty]?["\(departmentNumber)"] = groupsArray
                    }
                }
                
                completion(data)
            }
        }
    }
}

extension SignupController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateNextButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            firstNameField.becomeFirstResponder()
        case firstNameField:
            firstNameField.resignFirstResponder()
            showGroupPicker()
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == groupField {
            return false
        }
        
        return true
    }
}

extension SignupController: GroupPickerControllerDelegate {
    
    func groupDidChoose(_ group: String) {
        self.group = group
        updateGroupField()
        updateNextButton()
    }
}
