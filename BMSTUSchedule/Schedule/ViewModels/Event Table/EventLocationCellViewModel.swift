//
//  EventLocationCellViewModel.swift
//  BMSTUSchedule
//
//  Created by a.belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit

class EventLocationCellViewModel: CellViewModel {

    var location: String
    var locationDescription: String
    
    init(location: String) {
        
        let locationManager = LocationHelper()
        
        self.location = location
        self.locationDescription = locationManager.description(for: location)
        
        super.init(identifier: String(describing: EventLocationCell.self))
    }
}
