//
//  MapAdapter.swift
//  Skatable
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
                annotationView.image = mapPin.imageView.image
            }
        }

        return annotationView
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
