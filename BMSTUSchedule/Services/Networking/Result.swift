//
//  Result.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 23/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import Foundation

enum Result<T, U> {
    case success(T)
    case failure(U)
    
    public var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    public var error: U? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}
