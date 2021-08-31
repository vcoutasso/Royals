//
//  MapPin.swift
//  Skatable
//
//  Created by Vinícius Couto on 31/08/21.
//

import MapKit

struct MapPin: Identifiable {
    let id = UUID()
    let type: MapPinType
    let coordinate: CLLocationCoordinate2D
}
