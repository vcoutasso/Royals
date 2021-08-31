//
//  MapPinAnnotation.swift
//  Skatable
//
//  Created by Vinícius Couto on 31/08/21.
//

import MapKit

class MapPinAnnotation: NSObject, MKAnnotation {
    let name: String?
    let type: MapPinType
    let coordinate: CLLocationCoordinate2D

    init(name: String, coordinate: CLLocationCoordinate2D, type: MapPinType) {
        self.name = name
        self.type = type
        self.coordinate = coordinate
    }
}
