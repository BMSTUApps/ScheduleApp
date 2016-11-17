//
//  APIManager.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 17/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import Foundation
import Alamofire

enum ScheduleRouter: URLRequestConvertible {
    
    case getSchedule(groupName: String)
    case getWeek()
    
    static let baseURLString = "https://schedule.bmstu.ru" // Wait for BMSTU API
    
    var method: HTTPMethod {
        switch self {
        case .getSchedule:
            return .get
        case .getWeek:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getSchedule(let groupName):
            return "/group/\(groupName)"
        case .getWeek():
            return "/week/)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try ScheduleRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
   
        return urlRequest
    }
}

