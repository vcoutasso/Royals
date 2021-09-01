//
//  LocationService.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import CoreLocation

protocol LocationAdapterDelegate: AnyObject {
    func didLocateUser()
}

final class LocationAdapter: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private(set) var currentLocation: CLLocation?

    weak var delegate: LocationAdapterDelegate?

    override init() {
        super.init()

        locationManager.delegate = self

        bootLocationService()
    }

    private func bootLocationService() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            delegate?.didLocateUser()
        }
    }
}
