//
//  UIImageView.swift
//  Royals
//
//  Created by Vinícius Couto on 14/09/21.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }

    func makeRoundedProfile() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.clear.cgColor
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
    }
}
