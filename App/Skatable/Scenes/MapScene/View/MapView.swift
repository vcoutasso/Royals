//
//  MapView.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import MapKit
import UIKit

final class MapView: UIView {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()

        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false

        return mapView
    }()

    func setupHierarchy() {
        addSubview(mapView)
    }

    func didLocateUser() {
        mapView.showsUserLocation = true
    }

    func setRegion(_ coordinateRegion: MKCoordinateRegion) {
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    init(delegate: MKMapViewDelegate) {
        super.init(frame: .zero)

        setupHierarchy()
        setupConstraints()

        mapView.delegate = delegate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
