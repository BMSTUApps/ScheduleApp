//
//  MenuController.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 02/11/2016.
//  Copyright © 2016 techpark-iOS. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    
    let menuItemSelectedColor = UIColor(red: 87/255, green: 108/255, blue: 126/255, alpha: 1)

    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change default image's tint color
        for imageView: UIImageView in self.imageViews {
            let color = UIColor(red: 161/255, green: 172/255, blue: 182/255, alpha: 1)
            imageView.image = imageView.image?.imageWithColor(newColor: color)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = menuItemSelectedColor
        selectedCell.selectedBackgroundView = backgroundView
        
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        
        selectedCell.contentView.backgroundColor = menuItemSelectedColor
    }

}

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
