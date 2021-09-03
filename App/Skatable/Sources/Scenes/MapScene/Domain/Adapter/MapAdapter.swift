//
//  MapAdapter.swift
//  Skatable
//
//  Created by Vinícius Couto on 01/09/21.
//

import MapKit

final class MapAdapter: NSObject, MKMapViewDelegate {
    // MARK: - Public variables

    weak var delegate: MapAdapterDelegate?

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
                annotationView.image = mapPin.image
            }
        }

        return annotationView
    }

    // TODO: This needs a smoother transition. Also, pretty sure just one annotation should be selected at a time
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPinAnnotation {
            // REVIEW: how this is done
            mapPin.isSelected.toggle()
            view.image = mapPin.image
        }
    }
}
