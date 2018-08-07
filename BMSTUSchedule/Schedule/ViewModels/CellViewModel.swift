//
//  CellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 07/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

protocol CellViewModelProtocol {
    func fillCell(model: CellViewModel)
}

class CellViewModel {

    let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }
}
