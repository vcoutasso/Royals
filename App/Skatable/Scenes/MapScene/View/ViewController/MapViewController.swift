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
    private lazy var addButton: MapButtonView = .init(iconName: Strings.Names.Icons.add, action: {})
    private lazy var locationButton: MapButtonView = .init(iconName: Strings.Names.Icons.location, action: {})

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
        view.addSubview(addButton)
        view.addSubview(locationButton)
    }

    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(LayoutMetrics.searchBarBottomOffset)
            make.leading.equalToSuperview().offset(LayoutMetrics.searchBarLeadingOffset)
            make.trailing.equalToSuperview().offset(LayoutMetrics.trailingOffset)
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

    private enum LayoutMetrics {
        static let searchBarBottomOffset: CGFloat = -30
        static let searchBarLeadingOffset: CGFloat = 5
        static let trailingOffset: CGFloat = -5
        static let addButtonTopOffset: CGFloat = 15
        static let buttonDistance: CGFloat = 5
    }
}

extension MapViewController: LocationAdapterDelegate, MapAdapterDelegate {
    func didLocateUser() { mapView.didLocateUser() }

    func willLocateUser() {
        guard let location = locationAdapter.currentLocation else { return }

        mapView.centerMap(to: location)
    }
}
