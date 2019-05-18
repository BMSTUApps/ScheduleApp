//
//  AppRouter.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class AppRouter {

    enum Window: Int {
        case main = 0
        case activityIndicator = 101
        
        var window: UIWindow {
            return UIApplication.shared.windows.first(where: { window -> Bool in
                return window.tag == self.rawValue
            })!
        }
    }
    
    enum ModuleStoryboard: String {
        case main
        case authorization
        
        var storyboard: UIStoryboard {
            return UIStoryboard(name: self.rawValue.capitalized, bundle: nil)
        }
        
        var controller: UIViewController {
            return storyboard.instantiateInitialViewController()!
        }
    }
    
    func openMain() {
        let vc = ModuleStoryboard.main.controller
        let window = Window.main.window
        window.rootViewController = vc
    }
    
    func openAuthorization() {
        let vc = ModuleStoryboard.authorization.controller
        let window = Window.main.window
        window.rootViewController = vc
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
