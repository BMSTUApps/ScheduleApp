//
//  SignupController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class SignupController: UITableViewController {

    @IBOutlet private weak var emailField: RoundTextField!
    @IBOutlet private weak var passwordField: RoundTextField!
    @IBOutlet private weak var lastNameField: RoundTextField!
    @IBOutlet private weak var firstNameField: RoundTextField!
    @IBOutlet private weak var nextButton: UIButton!
    
    private var emailValid: Bool = false
    private var passwordValid: Bool = false
    private var lastNameValid: Bool = false
    private var firstNameValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        lastNameField.delegate = self
        firstNameField.delegate = self
        
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lastNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        firstNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        updateNextButton()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // MARK: Actions
    
    @IBAction func nextTapped(_ sender: Any) {
        // TODO: Open schedule chooser
    }
    
    private func updateNextButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.nextButton.isEnabled = self.emailValid && self.passwordValid && self.lastNameValid && self.firstNameValid
            self.nextButton.backgroundColor = self.nextButton.isEnabled ? AppTheme.AppColor.blue : AppTheme.AppColor.lightGray
        }
    }
}

extension SignupController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case emailField:
            emailValid = text.isEmail
        case passwordField:
            passwordValid = text.count > 8
        case lastNameField:
            lastNameValid = text.count > 5
        case firstNameField:
            firstNameValid = text.count > 5
        default:
            break
        }
        
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
        default:
            break
        }
        
        return true
    }
}
