//
//  ActivityIndicator.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 11/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

class ActivityIndicator {

    static let standart = ActivityIndicator(size: .init(width: 40,
                                                        height: 40))
    
    private let size: CGSize
    
    private var indicator = UIActivityIndicatorView()
    private var window = UIWindow()
    
    init(size: CGSize) {
        self.size = size
    }
    
    func prepare() {
        window.rootViewController = UIViewController()
        window.windowLevel = .alert
        window.tag = AppRouter.Window.activityIndicator.rawValue
        window.layer.cornerRadius = size.width / 2
        window.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        if let rootFrame = UIApplication.shared.windows.first?.frame {
            let rect = CGRect(x: rootFrame.origin.x + (rootFrame.width - size.width) / 2,
                              y: rootFrame.origin.y + (rootFrame.height - size.height) / 2,
                              width: size.width,
                              height: size.height)
            window.frame = rect
        } else {
            window.frame = CGRect(origin: .zero, size: size)
        }
        
        if let containterView = window.rootViewController?.view {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.style = .white

            containterView.addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.topAnchor.constraint(equalTo: containterView.topAnchor),
                indicator.bottomAnchor.constraint(equalTo: containterView.bottomAnchor),
                indicator.rightAnchor.constraint(equalTo: containterView.rightAnchor),
                indicator.leftAnchor.constraint(equalTo: containterView.leftAnchor)
            ])
        }
        
        window.makeKeyAndVisible()
        window.isHidden = true
    }
    
    func start() {
        window.isHidden = false
        indicator.startAnimating()
    }
    
    func stop() {
        indicator.stopAnimating()
        window.isHidden = true
    }
}
