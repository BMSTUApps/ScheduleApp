//
//  ScheduleProvider.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation

class ScheduleProvider {

    private let network = NetworkingService()
    private let realm = RealmService()
    
    func getScheduleStream(for group: Group, completion: (ScheduleStream?) -> Void) {
        
    }
    
    func getSchedule(completion: (Result<[Event], Error?>) -> Void) {
        let authorization = Authorization(accessToken: "Bearer /CvTI4NfIfrIGP20Gy3Tbw==")
        network.makeRequest(module: .schedule, method: (.get, ""), authorization: authorization) { result in
            
    
            
            print(result)
        }
    }
}
