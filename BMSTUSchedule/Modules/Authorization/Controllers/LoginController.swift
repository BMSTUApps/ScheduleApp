//
//  LoginController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    private var provider: AuthorizationProvider {
        return AppManager.shared.authorizationProvider
    }
    
    @IBOutlet private weak var emailField: RoundTextField!
    @IBOutlet private weak var passwordField: RoundTextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    @IBOutlet private weak var contentView: UIView!
    
    private var emailValid: Bool = false
    private var passwordValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        updateLoginButton()
    }

    // MARK: Actions
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text else {
            return
        }
        
        ActivityIndicator.standart.start()
        provider.login(email: email, password: password) { session in
            DispatchQueue.main.async {
                ActivityIndicator.standart.stop()
            }
            
            guard session != nil else {
                // TODO: Show error
                return
            }
            
            DispatchQueue.main.async {
                AppManager.shared.router.openMain()
            }
        }
    }
    
    private func updateLoginButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.loginButton.isEnabled = self.emailValid && self.passwordValid
            self.loginButton.backgroundColor = self.loginButton.isEnabled ? AppTheme.AppColor.blue : AppTheme.AppColor.lightGray
        }
    }
}

extension LoginController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case emailField:
            emailValid = text.isEmail
        case passwordField:
            passwordValid = !text.isEmpty
        default:
            break
        }
        
        updateLoginButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
