//
//  ViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 25/08/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set background color to green for test purposes
        self.view.backgroundColor = UIColor.green

        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.textAlignment = .right
        cluesLabel.text = "Score: 0"
        view.addSubview(cluesLabel)

        NSLayoutConstraint.activate([
            cluesLabel
                .topAnchor
                .constraint(equalTo: view
                                .layoutMarginsGuide
                                .topAnchor),
            cluesLabel
                .trailingAnchor
                .constraint(equalTo: view
                                .layoutMarginsGuide
                                .trailingAnchor)
        ])

        mapView.frame = CGRect(x: view.safeAreaLayoutGuide.layoutFrame.minX,
                               y: view.safeAreaLayoutGuide.layoutFrame.minY,
                               width: view.safeAreaLayoutGuide.layoutFrame.size.width,
                               height: view.safeAreaLayoutGuide.layoutFrame.size.height)

        mapView.mapType = MKMapType.standard
                mapView.isZoomEnabled = true
                mapView.isScrollEnabled = true

        view.addSubview(mapView)
    }

}
