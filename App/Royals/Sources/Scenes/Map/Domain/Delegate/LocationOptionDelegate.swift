//
//  LocationOptionDelegate.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 19/09/21.
//

import Foundation

protocol LocationOptionDelegate: AnyObject {
    func sendValue(uid: String, type: MenuType)
}

enum MenuType {
    case feed
    case rating
    case report
}
