//
//  UIView.swift
//  Royals
//
//  Created by Vinícius Couto on 18/09/21.
//

import UIKit

extension UIView {
    func makeRounded(borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.black.cgColor) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }

    func makeRectangle(color: UIColor, cornerRadius: CGFloat) {
        backgroundColor = color
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
