//
//  ScheduleProvider.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation

class ScheduleProvider {

    private var network: NetworkingService {
        return AppManager.shared.networkingService
    }
    
    private var realm: RealmService {
        return AppManager.shared.realmService
    }
    
    func getGroupSchedule(completion: @escaping (Schedule?) -> Void) {
        guard let group = AppManager.shared.currentGroup else {
            completion(nil)
            return
        }
        
        getSchedule(for: group, completion: completion)
    }
    
    func getSchedule(for group: Group, completion: @escaping (Schedule?) -> Void) {
        let schedule = realm.getSchedule(id: group.scheduleID)
        
        // If not in the realm -> download from the server
        guard schedule == nil else {
            completion(schedule)
            return
        }
        
        let parameters: RequestParameters = ["group": group.name]
        network.makeRequest(module: .schedule, method: (.get, "template"), parameters: parameters) { result in
            
            print("test")
            
            switch result {
            case .failure(let error):
                // TODO: Handle error
                break
            case .success(let json):
                
                if let schedule = Schedule(json) {
                    
                    // If got the schedule -> cache it in the realm.
                    self.realm.saveSchedule(schedule)
                    completion(schedule)
                    return
                }
            }
            
            completion(nil)
            return
        }
    }
    
//    func getSchedule(completion: (Result<[Event], Error?>) -> Void) {
//        let authorization = Authorization(accessToken: "Bearer /CvTI4NfIfrIGP20Gy3Tbw==")
//        network.makeRequest(module: .schedule, method: (.get, ""), authorization: authorization) { result in
//
//
//
//            print(result)
//        }
//    }
}
