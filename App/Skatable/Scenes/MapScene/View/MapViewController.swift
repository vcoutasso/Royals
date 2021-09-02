//
//  MapViewController.swift
//  Skatable
//
//  Created by Bruno Thuma on 27/08/21.
//

import MapKit
import UIKit

final class MapViewController: UIViewController {
    // MARK: - Private variables

    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    private lazy var mapView: MapView = .init(delegate: mapAdapter)

    // MARK: - Overridden methods

    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationAdapter.delegate = self
        mapAdapter.delegate = self

        // TODO: this ugly. make pretty.
        #if DEBUG
            let repository = MapPinAnnotationRepository()
            let pins = repository.pins()
            mapView.addPins(pins)
        #endif
    }
}

extension MapViewController: LocationAdapterDelegate, MapAdapterDelegate {
    func didLocateUser() { mapView.didLocateUser() }

    func willLocateUser() {
        guard let location = locationAdapter.currentLocation else { return }

        mapView.centerMap(to: location)
    }
}
