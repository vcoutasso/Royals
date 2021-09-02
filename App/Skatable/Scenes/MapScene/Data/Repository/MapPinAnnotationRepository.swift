//
//  MapPinAnnotationRepository.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import Foundation

final class MapPinAnnotationRepository {
    func pins() -> [MapPinAnnotation] {
        [
            MapPinAnnotation.fixtureSpot(),
            MapPinAnnotation.fixtureStopper(),
        ]
    }
}
