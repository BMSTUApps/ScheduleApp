//
//  LoginController.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    private var provider: AuthorizationProvider {
        return AppManager.shared.authorizationProvider
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var emailField: RoundTextField!
    @IBOutlet private weak var passwordField: RoundTextField!
    
    @IBOutlet private weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Login
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // TODO: Sign up
    }
}
