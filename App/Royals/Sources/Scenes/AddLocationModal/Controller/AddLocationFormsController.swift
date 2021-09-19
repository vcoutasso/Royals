//
//  AddLocationFormsController.swift
//  Royals
//
//  Created by Bruno Thuma on 07/09/21.
//

import MapKit
import UIKit

class AddLocationFormsController: UIViewController {
    // MARK: - Public variables

//    weak var modalDelegate: ModalViewControllerDelegate?

    // MARK: - Private variables

    private var locationType: MapPinType

    private lazy var mapView: MKMapView = .init()
    private let mapAdapter: MapAdapter = .init()

    init(locationType: MapPinType) {
        self.locationType = locationType

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        setupViews()
    }

    private func setupViews() {
        view = AddLocationFormView(theme: locationType)

//        mapView.mapType = MKMapType.standard
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        mapView.showsCompass = false
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        mapView.delegate = mapAdapter
    }
}

#if DEBUG
    import SwiftUI
    struct AddLocationFormsPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                return AddLocationFormsController(locationType: .skateSpot)
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
