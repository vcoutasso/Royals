//
//  AddPinForms.swift
//  Skatable
//
//  Created by Bruno Thuma on 07/09/21.
//

import MapKit
import UIKit

class AddLocationFormsController: UIViewController {
    // MARK: - Public variables

    weak var modalDelegate: ModalViewControllerDelegate?

    // MARK: - Private variables

    private lazy var mapView: MKMapView = .init()
    private let mapAdapter: MapAdapter = .init()

    override func loadView() {
        setupViews()
    }

    private func setupViews() {
        print("setting up views")
//        mapView.mapType = MKMapType.standard
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        mapView.showsCompass = false
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        mapView.delegate = mapAdapter
    }

    // MARK: - Public Methods

    func presentSpot() -> AddLocationFormsController {
        view = AddLocationFormView(theme: .skateSpot)
        return self
    }

    func presentStopper() -> AddLocationFormsController {
        view = AddLocationFormView(theme: .skateStopper)
        return self
    }
}

#if canImport(SwiftUI) && DEBUG
    import SwiftUI
    struct SwiftLeeViewRepresentable: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            return AddLocationFormView(theme: .skateSpot)
        }

        func updateUIView(_ view: UIView, context: Context) {}
    }

    @available(iOS 14.0, *)
    struct JonasBrothersPreview: PreviewProvider {
        static var previews: some View {
            SwiftLeeViewRepresentable()
        }
    }
#endif
