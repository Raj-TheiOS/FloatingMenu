//
//  UIColors+FloatingMenu.swift
//  FloatingMenu
//
//  Created by K Rajeshwar on 20/04/23.
//

import Foundation
import UIKit

extension UIColor {
    class var flatWhiteColor: UIColor {
        return UIColor(red: 0.9274, green: 0.9436, blue: 0.95, alpha: 1.0)
    }

    class var flatBlackColor: UIColor {
        return UIColor(red: 0.1674, green: 0.1674, blue: 0.1674, alpha: 1.0)
    }

    class var flatBlueColor: UIColor {
        return UIColor(red: 0.3132, green: 0.3974, blue: 0.6365, alpha: 1.0)
    }

    class var flatRedColor: UIColor {
        return UIColor(red: 0.9115, green: 0.2994, blue: 0.2335, alpha: 1.0)
    }
    var pixelImage: UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)

        self.setFill()
        UIRectFill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
