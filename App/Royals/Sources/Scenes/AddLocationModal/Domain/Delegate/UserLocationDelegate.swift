//
//  UserLocationDelegate.swift
//  Royals
//
//  Created by Bruno Thuma on 18/09/21.
//

import UIKit
import MapKit

protocol UserLocationDelegate: AnyObject {
    func setLastKnownLocation(_ location: CLLocation)
}
