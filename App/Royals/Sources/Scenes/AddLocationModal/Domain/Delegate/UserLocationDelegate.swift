//
//  UserLocationDelegate.swift
//  Royals
//
//  Created by Bruno Thuma on 18/09/21.
//

import MapKit
import UIKit

protocol UserLocationDelegate: AnyObject {
    func setLastKnownLocation(_ location: CLLocation)
}
