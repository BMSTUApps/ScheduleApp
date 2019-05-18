//
//  AppRouter.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 18/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class AppRouter {

    enum ModuleStoryboard: String {
        case authorization
        
        var storyboard: UIStoryboard? {
            return UIStoryboard(name: self.rawValue.capitalized, bundle: nil)
        }
        
        var controller: UIViewController? {
            return storyboard?.instantiateInitialViewController()
        }
    }
    
    func openAuthorization() {
        guard let vc = ModuleStoryboard.authorization.controller else {
            return
        }
        
        let topVC = topViewController(controller: UIApplication.shared.windows.first?.rootViewController)
        topVC?.present(vc, animated: false, completion: nil)
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
