//
//  MapPinAnnotationRepository.swift
//  Royals
//
//  Created by Vinícius Couto on 01/09/21.
//

import Foundation

#if DEBUG
    final class MapPinAnnotationRepository {
        func pins() -> [MapPinAnnotation] {
            [
                MapPinAnnotation.fixtureSpot(),
                MapPinAnnotation.fixtureStopper(),
            ]
        }
    }
#endif
