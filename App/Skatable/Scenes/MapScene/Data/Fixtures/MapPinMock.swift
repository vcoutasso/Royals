//
//  MapPinMock.swift
//  Skatable
//
//  Created by Vinícius Couto on 31/08/21.
//

import MapKit

#if DEBUG
    extension MapPinAnnotation {
        static func fixtureSpot(
            title: String = "Spot da massa",
            type: MapPinType = .skateSpot,
            coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -25.4174327, longitude: -49.2690548)
        )
            -> MapPinAnnotation
        {
            MapPinAnnotation(title: title, coordinate: coordinate, type: type)
        }

        static func fixtureStopper(
            title: String = "Stopper da massa",
            type: MapPinType = .skateStopper,
            coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(
                latitude: -25.4525344,
                longitude: -49.2513098
            )
        )
            -> MapPinAnnotation
        {
            MapPinAnnotation(title: title, coordinate: coordinate, type: type)
        }
    }
#endif
