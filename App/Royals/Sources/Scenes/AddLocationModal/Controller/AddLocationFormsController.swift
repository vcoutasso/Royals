//
//  AddPinForms.swift
//  Skatable
//
//  Created by Bruno Thuma on 07/09/21.
//

import MapKit
import UIKit

class AddLocationFormsController: UIViewController {
    private lazy var mapView: MKMapView = .init()
    private let mapAdapter: MapAdapter = .init()
    private let locationForm: AddLocationFormView = .init(theme: .skateSpot)

    override func loadView() {
        view = locationForm
        locationForm.mapBottomView = mapView

        setupViews()
    }

    private func setupViews() {
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = mapAdapter
    }
}

//#if DEBUG
//    import SwiftUI
//    struct AddLocationFormsPreview: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//                .previewDevice("iPhone 12")
//                .preferredColorScheme(.dark)
//        }
//
//        struct ContentView: AddLocationFormsController {
//            func makeUIViewController(context _: Context) -> UIViewController {
//                return AddLocationFormsViewController()
//            }
//
//            func updateUIViewController(_: UIViewController, context _: Context) {}
//        }
//    }
//#endif
