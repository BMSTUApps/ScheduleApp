//
//  UIImage+Color.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 04/06/2017.
//  Copyright © 2017 BMSTU Team. All rights reserved.
//

import UIKit

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
