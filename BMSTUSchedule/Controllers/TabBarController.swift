//
//  TabBarController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 12/02/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

enum TabIndex: Int {
    case schedule = 0
    case groups   = 1
    case settings = 2
}

class TabBarController: UITabBarController {

    // MARK: Constants
    
    let tabBarHeight: CGFloat = 45
    let tabTitleFont = UIFont.systemFont(ofSize: 10)
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Normal
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: Theme.current.ligthGrayColor,
                                                          NSFontAttributeName: self.tabTitleFont], for: .normal)
        
        // Selected
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image, let selectedImage = item.selectedImage {
                
                // Normal
                item.image = image.imageWithColor(newColor: Theme.current.ligthGrayColor).withRenderingMode(.alwaysOriginal)
                
                // Selected
                let index = TabIndex(rawValue: self.tabBar.items!.index(of: item)!) ?? .schedule
                switch index {
                case .schedule:
                    item.selectedImage = selectedImage.imageWithColor(newColor: Theme.current.greenColor).withRenderingMode(.alwaysOriginal)
                    item.setTitleTextAttributes([NSForegroundColorAttributeName: Theme.current.greenColor,
                                                 NSFontAttributeName: self.tabTitleFont], for: .selected)
                    break
                case .groups:
                    item.selectedImage = selectedImage.imageWithColor(newColor: Theme.current.blueColor).withRenderingMode(.alwaysOriginal)
                    item.setTitleTextAttributes([NSForegroundColorAttributeName: Theme.current.blueColor,
                                                 NSFontAttributeName: self.tabTitleFont], for: .selected)
                    break
                case .settings:
                    item.selectedImage = selectedImage.imageWithColor(newColor: Theme.current.defaultsColor).withRenderingMode(.alwaysOriginal)
                    item.setTitleTextAttributes([NSForegroundColorAttributeName: Theme.current.defaultsColor,
                                                 NSFontAttributeName: self.tabTitleFont], for: .selected)
                    break
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = self.tabBarHeight
        tabFrame.origin.y = self.view.frame.size.height - self.tabBarHeight
        self.tabBar.frame = tabFrame
    }
}
