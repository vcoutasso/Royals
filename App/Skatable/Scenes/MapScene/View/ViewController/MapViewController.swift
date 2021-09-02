//
//  MapViewController.swift
//  Skatable
//
//  Created by Bruno Thuma on 27/08/21.
//

import UIKit

final class MapViewController: UIViewController {
    // MARK: - Private variables

    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    private lazy var mapView: MapView = .init(delegate: mapAdapter)
    private lazy var searchBar: SearchBarView = .init()

    // MARK: - Overridden methods

    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(searchBar)

        searchBar.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(LayoutMetrics.searchBarBottomOffset)
            make.leading.equalToSuperview().offset(LayoutMetrics.searchBarLeadingOffset)
            make.trailing.equalToSuperview().offset(LayoutMetrics.searchBarTrailingOffset)
        }

        locationAdapter.delegate = self
        mapAdapter.delegate = self

        // TODO: this ugly. make pretty.
        #if DEBUG
            let repository = MapPinAnnotationRepository()
            let pins = repository.pins()
            mapView.addPins(pins)
        #endif
    }

    // MARK: - Private methods

    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
