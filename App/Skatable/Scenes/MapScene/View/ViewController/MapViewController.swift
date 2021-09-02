//
//  MapViewController.swift
//  Skatable
//
//  Created by Bruno Thuma on 27/08/21.
//

import SnapKit
import UIKit

final class MapViewController: UIViewController {
    // MARK: - Private variables

    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    private lazy var mapView: MapView = .init(delegate: mapAdapter)
    private lazy var searchBar: SearchBarView = .init()

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupConstraints()
        setupDelegates()

        // TODO: this ugly. make pretty.
        #if DEBUG
            let repository = MapPinAnnotationRepository()
            let pins = repository.pins()
            mapView.addPins(pins)
        #endif
    }

    // MARK: - Private methods

    private func setupDelegates() {
        locationAdapter.delegate = self
        mapAdapter.delegate = self
    }

    private func setupHierarchy() {
        view.addSubview(mapView)
        view.addSubview(searchBar)
    }

    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(LayoutMetrics.searchBarBottomOffset)
            make.leading.equalToSuperview().offset(LayoutMetrics.searchBarLeadingOffset)
            make.trailing.equalToSuperview().offset(LayoutMetrics.searchBarTrailingOffset)
        }
    }

    private enum LayoutMetrics {
        static let searchBarBottomOffset: CGFloat = -30
        static let searchBarLeadingOffset: CGFloat = 5
        static let searchBarTrailingOffset: CGFloat = -5
    }
}

extension MapViewController: LocationAdapterDelegate, MapAdapterDelegate {
    func didLocateUser() { mapView.didLocateUser() }

    func willLocateUser() {
        guard let location = locationAdapter.currentLocation else { return }

        mapView.centerMap(to: location)
    }
}
