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

    private var formsView: AddLocationFormView!

    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    // MARK: - Constructor

    init(locationType: MapPinType) {
        self.locationType = locationType

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden Methods

    override func loadView() {
        formsView = AddLocationFormView(delegate: self, theme: locationType) { [weak self] in
            self?.registerLocation()
        }
        setupViews()
    }

    override func viewDidLoad() {
        formsView.mapView.setRegion(MKCoordinateRegion(center: lastKnownLocation!.coordinate,
                                                       latitudinalMeters: LayoutMetrics.centeringRegionRadius,
                                                       longitudinalMeters: LayoutMetrics.centeringRegionRadius),
                                    animated: true)

        formsView.mapView.showsUserLocation = true
    }

    // MARK: - Private Methods

    private func setupViews() {
        formsView.mapView.delegate = mapAdapter

        // FIXME: We should be adding subviews, not replacing the entire view
        view = formsView
    }

    private func registerLocation() {
        let id: String = randomNonceString()
        let name: String = formsView.getName()
        let location: CLLocation = formsView.getLocation()
        let description: String = formsView.getDescription()

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        var streetName: String = ""
        var city: String = ""
        var neighborhood: String = ""

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }

            if let firstPlacemark = placemarks?.first {
                streetName = firstPlacemark.thoroughfare ?? ""
                city = firstPlacemark.locality ?? ""
                neighborhood = firstPlacemark.subLocality ?? ""
            }
        }

        FirestoreService().addLocation(LocationData(id: id,
                                                    name: name,
                                                    latitude: latitude,
                                                    longitude: longitude,
                                                    street: streetName,
                                                    city: city,
                                                    neighborhood: neighborhood,
                                                    description: description))

        dismiss(animated: true, completion: nil)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 500
    }
}

extension AddLocationFormsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

extension AddLocationFormsController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }

        return true
    }
}

extension AddLocationFormsController: UserLocationDelegate {
    func setLastKnownLocation(_ location: CLLocation) {
        lastKnownLocation = location
    }
}
