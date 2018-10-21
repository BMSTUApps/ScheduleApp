//
//  UIImageView+Network.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 30/09/2018.
//  Copyright © 2018 BMSTU Team. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(from url: URL) {
        
        let resource = ImageResource(downloadURL: url)
        
        self.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
