//
//  TableViewModel.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 13/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

protocol TableViewModelProtocol {
    
    func viewModel(for indexPath: IndexPath) -> CellViewModel?
}

class TableViewModel: TableViewModelProtocol {

    var count: Int {
        return viewModels.count
    }
    
    internal var viewModels: [CellViewModel] = []
    
    func viewModel(for indexPath: IndexPath) -> CellViewModel? {
        
        if indexPath.row < viewModels.count {
            return viewModels[indexPath.row]
        }
        
        return nil
    }
}
