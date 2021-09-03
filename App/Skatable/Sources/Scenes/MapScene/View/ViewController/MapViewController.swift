//
//  MapViewController.swift
//  Skatable
//
//  Created by Bruno Thuma on 27/08/21.
//

import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    // MARK: - Private variables

    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    private lazy var mapView: MKMapView = .init()
    private lazy var searchBar: SearchBarView = .init()

    private lazy var addButton: MapButtonView = .init(iconName: Strings.Names.Icons.add, action: presentAddMenuModal)
    private lazy var locationButton: MapButtonView = .init(
        iconName: Strings.Names.Icons.location,
        action: willLocateUser
    )

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
        setupDelegates()

        // TODO: this ugly. make pretty.
        #if DEBUG
            let repository = MapPinAnnotationRepository()
            let pins = repository.pins()
            mapView.addAnnotations(pins)
        #endif
    }

    // MARK: - Private methods

    private func setupViews() {
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = mapAdapter
    }

    private func setupDelegates() {
        locationAdapter.delegate = self
        mapAdapter.delegate = self
    }

    private func setupHierarchy() {
        view.addSubview(mapView)
        view.addSubview(searchBar)
        view.addSubview(addButton)
        view.addSubview(locationButton)
    }

    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(LayoutMetrics.searchBarBottomOffset)
            make.leadingMargin.equalToSuperview().offset(LayoutMetrics.searchBarLeadingOffset)
            make.trailingMargin.equalToSuperview().offset(LayoutMetrics.trailingOffset)
        }

        addButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(LayoutMetrics.addButtonTopOffset)
            make.trailingMargin.equalToSuperview().offset(LayoutMetrics.trailingOffset)
        }

        locationButton.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(LayoutMetrics.buttonDistance)
            make.trailingMargin.equalToSuperview().offset(LayoutMetrics.trailingOffset)
        }
    }

    private func presentAddMenuModal() {
        let menuVC = AddMenuViewController()
        modalPresentationStyle = .overCurrentContext
        present(menuVC, animated: true, completion: {})
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 1000
        static let searchBarBottomOffset: CGFloat = -30
        static let searchBarLeadingOffset: CGFloat = 5
        static let trailingOffset: CGFloat = -5
        static let addButtonTopOffset: CGFloat = 15
        static let buttonDistance: CGFloat = 5
    }
}

extension MapViewController: LocationAdapterDelegate, MapAdapterDelegate {
    func didLocateUser() { mapView.showsUserLocation = true }

    func willLocateUser() {
        guard let location = locationAdapter.currentLocation else { return }

        mapView.setRegion(MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: LayoutMetrics.centeringRegionRadius,
            longitudinalMeters: LayoutMetrics.centeringRegionRadius
        ), animated: true)
    }
}
