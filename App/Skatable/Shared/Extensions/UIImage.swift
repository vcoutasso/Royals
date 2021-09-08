//
//  UIImage.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import UIKit

extension UIImage {
    // From https://stackoverflow.com/a/37158317
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
