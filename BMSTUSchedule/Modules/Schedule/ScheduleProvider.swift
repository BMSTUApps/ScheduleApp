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
    
    private var defaults: DefaultsService {
        return AppManager.shared.defaultsService
    }
    
    func getSchedule(completion: @escaping (Schedule?) -> Void) {
        switch AppManager.shared.authorizationState {
        case .authorized(let session):
            getSchedule(session: session, completion: completion)
        case .template(let group):
            getSchedule(for: group, completion: completion)
        case .unauthorized:
            completion(nil)
        }
    }
    
    func getSchedule(session: Session, completion: @escaping (Schedule?) -> Void) {
        
        // If schedule is cached -> return cached
        if let scheduleID = defaults.userScheduleID, let schedule = realm.getSchedule(id: scheduleID) {
            print("Return schedule '\(schedule.id)' from realm")
            completion(schedule)
            return
        }
        
        // If not in the realm -> download from the server
        network.makeRequest(module: .schedule, method: (.get, ""), session: session) { result in
            switch result {
            case .failure(let error):
                // TODO: Handle error
                break
            case .success(let json):
                if let schedule = Schedule(json) {
                    
                    // If got the schedule -> cache it in the realm.
                    self.realm.saveSchedule(schedule)
                    
                    // -> also save schedule id to UserDefaults
                    self.defaults.userScheduleID = schedule.id
                    
                    print("Return schedule '\(schedule.id)' from server")
                    completion(schedule)
                    return
                }
            }
            
            completion(nil)
        }
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
        }
    }
    
    func getEvent(from streamingEvent: StreamingEvent) -> Event? {
        return realm.getEvent(id: streamingEvent.id)
    }
}
