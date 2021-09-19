//
//  UIResponder.swift
//  Royals
//
//  Created by Vinícius Couto on 19/09/21.
//

import UIKit

public extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
