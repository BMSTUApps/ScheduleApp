//
//  SignupController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit
import SPStorkController

class SignupController: UITableViewController {
    
    @IBOutlet private weak var emailField: RoundTextField!
    @IBOutlet private weak var passwordField: RoundTextField!
    @IBOutlet private weak var lastNameField: RoundTextField!
    @IBOutlet private weak var firstNameField: RoundTextField!
    @IBOutlet private weak var groupField: RoundTextField!
    @IBOutlet private weak var nextButton: UIButton!

    private var provider: AuthorizationProvider {
        return AppManager.shared.authorizationProvider
    }
    
    private var group: PickerGroup?
    
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
        if let group = group, !group.name.isEmpty {
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
        guard let firstName = firstNameField.text,
            let lastName = lastNameField.text,
            let email = emailField.text,
            let password = passwordField.text,
            let scheduleID = group?.scheduleID else {
                return
        }
        
        ActivityIndicator.standart.start()
        provider.signUp(email: email, password: password, firstName: firstName, lastName: lastName, scheduleID: scheduleID) { session in
            DispatchQueue.main.async {
                ActivityIndicator.standart.stop()
            }
            
            guard session != nil else {
                return
            }
            
            DispatchQueue.main.async {
                AppManager.shared.router.openMain()
            }
        }
    }
    
    // MARK: UI
    
    private func updateNextButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.nextButton.isEnabled = self.dataValid
            self.nextButton.backgroundColor = self.nextButton.isEnabled ? AppTheme.AppColor.blue : AppTheme.AppColor.lightGray
        }
    }
    
    private func updateGroupField() {
        groupField.text = group?.name
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
    
    // MARK: Data
    
    private func getPickerData(completion: @escaping (GroupPickerController.Data?) -> Void) {
        
        provider.getAvailableGroups { groups in
            guard let groups = groups else {
                completion(nil)
                return
            }
            
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
        return textField != groupField
    }
}

extension SignupController: GroupPickerControllerDelegate {
    
    func groupDidChoose(_ group: PickerGroup) {
        self.group = group
        updateGroupField()
        updateNextButton()
    }
}
