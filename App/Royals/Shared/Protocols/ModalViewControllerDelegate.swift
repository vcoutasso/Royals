//
//  ModalViewControllerDelegate.swift
//  Royals
//
//  Created by Bruno Thuma on 15/09/21.
//

import Foundation

protocol ModalViewControllerDelegate: AnyObject {
    func sendValue(selectedType: MapPinType)
}
