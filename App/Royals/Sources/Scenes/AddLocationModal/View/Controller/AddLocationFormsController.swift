//
//  AddPinForms.swift
//  Skatable
//
//  Created by Bruno Thuma on 07/09/21.
//

import MapKit
import UIKit

class AddLocationFormsController: UIViewController {
    // MARK: - User Input Variables
    
    private var lastKnownLocation: CLLocation?
    
    // MARK: - Private variables

    private var locationType: MapPinType

    private var formsView: AddLocationFormView
    
    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    // MARK: - Constructor

    init(locationType: MapPinType) {
        self.locationType = locationType
        self.formsView = AddLocationFormView(theme: locationType)

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden Methods

    override func loadView() {
        setupViews()
    }
    
    override func viewDidLoad() {
        formsView.mapView.setRegion(
            MKCoordinateRegion(
                center: lastKnownLocation!.coordinate,
                latitudinalMeters: LayoutMetrics.centeringRegionRadius,
                longitudinalMeters: LayoutMetrics.centeringRegionRadius),
            animated: true)

        formsView.mapView.showsUserLocation = true
    }

    // MARK: - Private Methods

    private func setupViews() {
        formsView.mapView.delegate = mapAdapter

        // TODO: Homework, is this good implementation?
        view = formsView
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 500
    }
}

extension AddLocationFormsController: UserLocationDelegate {
    func setLastKnownLocation(_ location: CLLocation) {
        lastKnownLocation = location
    }
}

#if canImport(SwiftUI) && DEBUG
    import SwiftUI
    struct FormViewRepresentable: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            return AddLocationFormView(theme: .skateSpot)
        }

        func updateUIView(_ view: UIView, context: Context) {}
    }

    @available(iOS 13.0, *)
    struct JonasBrothersPreview: PreviewProvider {
        static var previews: some View {
            FormViewRepresentable()
        }
    }
#endif