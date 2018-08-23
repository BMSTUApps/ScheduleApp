//
//  LocationHelper.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 08/08/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import Foundation

// TODO: To implement 'Location' class to 'Event'

class LocationHelper {

    class Location {
        
        enum Building: String {
            case main = "главное здание"
            case lab = "учебно-лабораторный корпус"
            case energo = "корпус \"Энерго\""
            case sport = "спорт-комлекс"
        }
        
        enum BuildingPart: String {
            case south = "южное крыло"
            case north = "северное крыло"
        }
        
        var building: Building
        var buildingPart: BuildingPart?
        var floor: Int?
        var room: String?
        
        var description: String {
            
            var descriptionString = ""
            
            if let floor = floor {
                descriptionString += "\(floor) этаж"
            }
            
            if let buildingPart = buildingPart {
                descriptionString += (descriptionString.count > 0) ? ", " : ""
                descriptionString += buildingPart.rawValue
            }
            
            descriptionString += (descriptionString.count > 0) ? ", " : ""
            descriptionString += building.rawValue
            
            return descriptionString
        }
        
        init(string: String) {
            
            let string = string.lowercased()

            // Detect a few chars abbreviation of building
            if string.range(of: "гз") != nil {
                self.building = .main
            } else if string.range(of: "ск") != nil {
                self.building = .sport
            } else if string.range(of: "улк") != nil {
                self.building = .lab
            } else {
                self.building = .main
            }
            
            // Detect room
            if let room = Int(String(string.filter { "0"..."9" ~= $0 })) {
                self.room = string
                self.floor = room / 100
                
                switch String(string.last!) {
                case "л":
                    self.building = .lab
                    break
                case "э":
                    self.building = .energo
                    break
                case "ю":
                    self.building = .main
                    self.buildingPart = .south
                    break
                case "0"..."9":
                    self.building = .main
                    self.buildingPart = .north
                default:
                    break
                }
              
            }
        }
    }
    
    func description(for location: String) -> String {

        let location = Location(string: location)
        
        return location.description
    }
}
