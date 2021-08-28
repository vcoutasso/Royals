//
//  ViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 25/08/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView()

        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        mapView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
