//
//  RoundTextField.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class RoundTextField: UITextField {

    private let textInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
}
