//
//  LocationOptionDelegate.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 19/09/21.
//

protocol LocationOptionDelegate {
    func sendValue(uid: String, type: MenuType)
}

enum MenuType {
    case feed
    case rating
    case report
}
