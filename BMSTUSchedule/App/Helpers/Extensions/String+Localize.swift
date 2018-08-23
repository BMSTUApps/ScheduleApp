//
//  String+Localize.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/02/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
