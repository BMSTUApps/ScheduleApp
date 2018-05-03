//
//  AppTheme.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 21/05/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

class AppTheme {

    static let shared = AppTheme()
    
    class AppColor {
        
        static let base = UIColor(red: 45/255, green: 62/255, blue: 79/255, alpha: 1)
        static let lightBase = UIColor(red: 89/255, green: 123/255, blue: 156/255, alpha: 1)

        static let blue = UIColor(red: 57/255, green: 152/255, blue: 219/255, alpha: 1)
        static let green = UIColor(red: 51/255, green: 187/255, blue: 156/255, alpha: 1)
        static let yellow = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        
        static let lightBlue = UIColor(red: 57/255, green: 152/255, blue: 219/255, alpha: 1)
        static let lightGreen = UIColor(red: 215/255, green: 255/255, blue: 246/255, alpha: 1)
        
        static let ligthGray = UIColor(red:137/255, green:161/255, blue:175/255, alpha: 1)
        
        static let white = UIColor.white
    }
    
    // MARK: - Colors
    
    let baseColor = AppColor.base
    let lightBaseColor = AppColor.lightBase
    
    let blueColor = AppColor.blue
    let greenColor = AppColor.green
    let yellowColor = AppColor.yellow
    
    let lightBlueColor = AppColor.lightBlue
    let lightGreenColor = AppColor.lightGreen
    
    let ligthGrayColor = AppColor.ligthGray
    
    // MARK: - Navigation bar
    
    let navigationBarTintColor = AppColor.white
    let navigationBarBackgroundColor = AppColor.base
}
