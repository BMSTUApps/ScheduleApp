//
//  RealmService.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 23/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private var database = try! Realm()
    
    func clear() {
        try! database.write {
            database.deleteAll()
        }
    }
    
    // MARK: Group
    
    func getGroup(id: Model.ID) -> Group? {
        guard let realmGroup = database.objects(RealmGroup.self).filter("serverID = '\(id)'").first else {
            return nil
        }
        
        return Group(realmGroup)
    }
    
    func saveGroup(_ group: Group) {
        let oldGroups = database.objects(RealmGroup.self).filter("serverID = '\(group.id)'")
        let realmGroup = RealmGroup(group)
        
        try! database.write {
            database.delete(oldGroups)
            database.add(realmGroup)
        }
    }
    
    // MARK: Schedule
    
    func getSchedule(id: Model.ID) -> Schedule? {
        guard let realmSchedule = database.objects(RealmSchedule.self).filter("serverID = '\(id)'").first else {
            return nil
        }
    
        return Schedule(realmSchedule)
    }
    
    func saveSchedule(_ schedule: Schedule) {
        let oldSchedules = database.objects(RealmSchedule.self).filter("serverID = '\(schedule.id)'")
        let realmSchedule = RealmSchedule(schedule)
        
        try! database.write {
            database.delete(oldSchedules)
            database.add(realmSchedule)
        }
    }
    
    // MARK: Event
    
    func getEvent(id: Model.ID) -> Event? {
        guard let realmEvent = database.objects(RealmEvent.self).filter("serverID = '\(id)'").first else {
            return nil
        }
        
        return Event(realmEvent)
    }
}
