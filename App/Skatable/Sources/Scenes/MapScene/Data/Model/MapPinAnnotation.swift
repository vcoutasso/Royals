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

    var isSelected: Bool = false

    // TODO: Could be better
    var image: UIImage? {
        var img: UIImage?

        switch type {
        case .skateSpot:
            img = UIImage(asset: Assets.Images.skateSpot)
        case .skateStopper:
            img = UIImage(asset: Assets.Images.skateStopper)
        }

        if isSelected {
            switch type {
            case .skateSpot:
                img = img?.imageWithColor(color: Assets.Colors.green.color)
            case .skateStopper:
                img = img?.imageWithColor(color: Assets.Colors.red.color)
            }
        }

        return img
    }

    init(title: String, coordinate: CLLocationCoordinate2D, type: MapPinType) {
        self.title = title
        self.type = type
        self.coordinate = coordinate
    }
}
