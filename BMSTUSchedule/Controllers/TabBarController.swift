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
    
    let tabNormalColor = UIColor(red:137/255, green:161/255, blue:175/255, alpha: 1)
    let tabSelectedColor = UIColor(red:206/255, green:229/255, blue:241/255, alpha: 1)

    let tabTitleFont = UIFont.systemFont(ofSize: 10)
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Normal
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: self.tabNormalColor,
                                                          NSFontAttributeName: self.tabTitleFont], for:.normal)
        
        // Selected
        
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image, let selectedImage = item.selectedImage {
                
                // Normal
                
                item.image = image.imageWithColor(newColor: self.tabNormalColor).withRenderingMode(.alwaysOriginal)
                
                // Selected
                
                let index = TabIndex(rawValue: self.tabBar.items!.index(of: item)!) ?? .schedule
                
                switch index {
                case .schedule:
                    item.selectedImage = selectedImage.imageWithColor(newColor: Theme.current.greenColor).withRenderingMode(.alwaysOriginal)
                    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: Theme.current.greenColor,
                                                                      NSFontAttributeName: self.tabTitleFont], for:.selected)
                    break
                case .groups:
                    item.selectedImage = selectedImage.imageWithColor(newColor: Theme.current.blueColor).withRenderingMode(.alwaysOriginal)
                    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: Theme.current.blueColor,
                                                                      NSFontAttributeName: self.tabTitleFont], for:.selected)
                    break
                case .settings:
                    item.selectedImage = selectedImage.imageWithColor(newColor: self.tabSelectedColor).withRenderingMode(.alwaysOriginal)
                    UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: self.tabSelectedColor,
                                                                      NSFontAttributeName: self.tabTitleFont], for:.selected)
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
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - 

extension UIImage {
    
    func imageWithColor(newColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        newColor.setFill()
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.size.width, height: self.size.height)) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
