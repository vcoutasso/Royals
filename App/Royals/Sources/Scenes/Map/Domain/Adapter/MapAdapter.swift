//
//  MapAdapter.swift
//  Royals
//
//  Created by Vinícius Couto on 01/09/21.
//

import MapKit

final class MapAdapter: NSObject, MKMapViewDelegate {
    // MARK: - Public attributes

    weak var delegate: MapAdapterDelegate?

    var currentSelection: MapPinAnnotation?

    // MARK: - Public methods

    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        delegate?.willLocateUser()
    }

    // Inspiration from https://stackoverflow.com/a/41342800
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation {
            let pin = mapView.view(for: annotation) as? MKPinAnnotationView
                ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.image = UIImage(asset: Assets.Images.userLocationMarker)

            return pin
        } else if let annotation = annotation as? MapPinAnnotation {
            let annotationIdentifier = annotation.type.rawValue
            var annotationView: MKAnnotationView?

            if let dequeuedAnnotationView = mapView
                .dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            } else {
                let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView = av
            }

            // Configure custom annotation view
            if let annotationView = annotationView {
                annotationView.canShowCallout = false

                // Set custom image for custom pins
                if let mapPin = annotationView.annotation as? MapPinAnnotation {
                    annotationView.image = mapPin.imageView.image
                }
            }

            return annotationView
        } else {
            return nil
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPinAnnotation {
            mapPin.isSelected = true
            view.image = mapPin.imageView.image
        }
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPinAnnotation {
            mapPin.isSelected = false
            view.image = mapPin.imageView.image
        }
    }
}
