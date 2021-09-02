//
//  MapView.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import MapKit

final class MapView: UIView {
    // MARK: - Private variables

    private lazy var map: MKMapView = {
        let map = MKMapView()

        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isRotateEnabled = true
        map.translatesAutoresizingMaskIntoConstraints = false

        return map
    }()

    // MARK: - Initialization

    init(delegate: MKMapViewDelegate) {
        super.init(frame: .zero)

        setupHierarchy()
        setupConstraints()

        map.delegate = delegate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func didLocateUser() {
        map.showsUserLocation = true
    }

    func centerMap(to location: CLLocation) {
        setRegion(MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: LayoutMetrics.centeringRegionRadius,
            longitudinalMeters: LayoutMetrics.centeringRegionRadius
        ))
    }

    func addPins(_ pins: [MKAnnotation]) {
        map.addAnnotations(pins)
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        addSubview(map)
    }

    private func setRegion(_ coordinateRegion: MKCoordinateRegion) {
        map.setRegion(coordinateRegion, animated: true)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: topAnchor),
            map.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            map.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            map.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 1000
    }
}
