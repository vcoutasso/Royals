//
//  MapViewController.swift
//  Skatable
//
//  Created by Bruno Thuma on 27/08/21.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    private var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView()
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false

        locationManager = CLLocationManager()
        locationManager.delegate = self

        // TODO: this ugly. make pretty.
        #if DEBUG
            let spot = MapPinAnnotation.fixtureSpot()
            let stopper = MapPinAnnotation.fixtureStopper()
            mapView.addAnnotations([spot, stopper])
        #endif

        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        getCurrentLocation()
    }

    func getCurrentLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            mapView.showsUserLocation = true
        }
    }

    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        centerMapToLocation(currentLocation, regionRadius: LayoutMetrics.centerToUserRegionRadius)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"

        var annotationView: MKAnnotationView?

        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }

        // Configure annotation view
        if let annotationView = annotationView {
            annotationView.canShowCallout = false

            // Set custom image for custom pins
            if let mapPin = annotationView.annotation as? MapPinAnnotation {
                switch mapPin.type {
                case .skateSpot:
                    annotationView.image = UIImage(asset: Assets.Images.skateSpot)
                case .skateStopper:
                    annotationView.image = UIImage(asset: Assets.Images.skateStopper)
                }
            }
        }

        return annotationView
    }

    // TODO: This needs a smoother transition. Also, pretty sure just one annotation should be selected at a time
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Set custom image for custom pins
        if let mapPin = view.annotation as? MapPinAnnotation {
            switch mapPin.type {
            case .skateSpot:
                view.image = view.image?.imageWithColor(color: Assets.Colors.green.color)
            case .skateStopper:
                view.image = view.image?.imageWithColor(color: Assets.Colors.red.color)
            }
        }
    }

    func centerMapToLocation(_ location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }

    private enum LayoutMetrics {
        static let centerToUserRegionRadius: CLLocationDistance = 1000
    }
}
