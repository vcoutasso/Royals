//
//  MapPinAnnotation.swift
//  Skatable
//
//  Created by Vinícius Couto on 31/08/21.
//

import MapKit

class MapPinAnnotation: NSObject, MKAnnotation {
    let title: String?
    let type: MapPinType
    let coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D, type: MapPinType) {
        self.title = title
        self.type = type
        self.coordinate = coordinate
    }
}
