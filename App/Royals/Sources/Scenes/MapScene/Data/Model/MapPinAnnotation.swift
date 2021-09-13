//
//  MapPinAnnotation.swift
//  Royals
//
//  Created by Vinícius Couto on 31/08/21.
//

import MapKit

class MapPinAnnotation: NSObject, MKAnnotation {
    // MARK: - Public attributes

    let id: UUID = .init()
    let unselectedColor: UIColor = Assets.Colors.lightGray.color

    let coordinate: CLLocationCoordinate2D
    let type: MapPinType
    let title: String?

    var isSelected: Bool = false {
        didSet {
            if isSelected {
                imageView.image = imageView.image?.imageWithColor(color: selectedColor)
            } else {
                imageView.image = imageView.image?.imageWithColor(color: unselectedColor)
            }
            imageView.layoutIfNeeded()
        }
    }

    // MARK: - Lazy variables

    lazy var imageView: UIImageView = {
        let asset = (self.type == .skateSpot) ? Assets.Images.skateSpot : Assets.Images.skateStopper

        return UIImageView(image: UIImage(asset: asset)!.imageWithColor(color: unselectedColor))
    }()

    lazy var selectedColor: UIColor = {
        (type == .skateSpot) ? Assets.Colors.green.color : Assets.Colors.red.color
    }()

    // MARK: - Initialization

    init(title: String, coordinate: CLLocationCoordinate2D, type: MapPinType) {
        self.coordinate = coordinate
        self.title = title
        self.type = type
    }
}
