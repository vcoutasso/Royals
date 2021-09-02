//
//  MapView.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import MapKit
import SnapKit

final class MapView: MKMapView {
    // MARK: - Initialization

    init(delegate: MKMapViewDelegate) {
        super.init(frame: .zero)

        setupView()

        self.delegate = delegate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func didLocateUser() {
        showsUserLocation = true
    }

    func centerMap(to location: CLLocation) {
        setRegion(MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: LayoutMetrics.centeringRegionRadius,
            longitudinalMeters: LayoutMetrics.centeringRegionRadius
        ))
    }

    func addPins(_ pins: [MKAnnotation]) {
        addAnnotations(pins)
    }

    // MARK: - Private methods

    private func setupView() {
        mapType = MKMapType.standard
        isZoomEnabled = true
        isScrollEnabled = true
        isRotateEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setRegion(_ coordinateRegion: MKCoordinateRegion) {
        setRegion(coordinateRegion, animated: true)
    }

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 1000
    }
}
