//
//  MapViewController.swift
//  Royals
//
//  Created by Bruno Thuma on 27/08/21.
//

import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    // MARK: - Private variables

    private let locationAdapter: LocationAdapter = .init()
    private let mapAdapter: MapAdapter = .init()

    private lazy var mapView: MKMapView = .init()
    private lazy var searchBar: SearchBarView = .init()
    private lazy var searchBarContainerView: UIView = .init(frame: .zero)
    private lazy var addButton: MapButtonView = .init(iconName: Strings.Names.Icons.add, action: presentAddMenuModal)
    private lazy var locationButton: MapButtonView = .init(iconName: Strings.Names.Icons.location,
                                                           action: willLocateUser)
    private var searchResultsController: SearchResultsViewController?

    private weak var userLocationDelegate: UserLocationDelegate?

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupDelegates()
        setupConstraints()

        // TODO: this ugly. make pretty.
        #if DEBUG
            let repository = MapPinAnnotationRepository()
            let pins = repository.pins()
            mapView.addAnnotations(pins)
        #endif
    }

    // MARK: - Private methods

    private func openSearchResultsView() {
        if let results = searchResultsController {
            UIView.animate(withDuration: LayoutMetrics.resultsViewAnimationDuration) { [weak self] in
                guard let self = self else { return }

                self.view.addSubview(results.view)
                results.view.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                    make.top.equalTo(self.navigationController!.navigationBar.snp.bottom)
                }
            }
        }
    }

    private func closeSearchResultsView() {
        if let results = searchResultsController {
            UIView.animate(withDuration: LayoutMetrics.resultsViewAnimationDuration) { [weak self] in
                guard let self = self else { return }

                results.view.removeFromSuperview()
                self.searchResultsController = nil
            }
        }
    }

    private func openSearchBar() {
        let openSearchBarBottomConstraint = (view.layoutMargins.top - mapView.frame.height)
            + LayoutMetrics.searchBarOpenBottomOffset

        UIView.animate(withDuration: LayoutMetrics.searchBarInteractionAnimationDuration,
                       delay: 0,
                       options: [.curveLinear],
                       animations: { [weak self] in
                           guard let self = self else { return }
                           self.searchBarContainerView.snp.updateConstraints { make in
                               make.bottomMargin.equalTo(openSearchBarBottomConstraint)
                           }

                           self.navigationController?.setNavigationBarHidden(false, animated: true)
                           self.searchBar.showsCancelButton = true

                           self.view.layoutIfNeeded()
                       }, completion: { [weak self] finished in
                           if finished {
                               guard let self = self else { return }
                               self.navigationItem.titleView = self.searchBar
                               self.searchResultsController = .init()
                               self.openSearchResultsView()
                           }
                       })
    }

    private func closeSearchBar() {
        closeSearchResultsView()

        searchBar.text = ""

        navigationItem.titleView = nil
        navigationController?.setNavigationBarHidden(true, animated: true)

        searchBarContainerView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        UIView.animate(withDuration: LayoutMetrics.searchBarInteractionAnimationDuration,
                       delay: 0,
                       options: [.curveLinear],
                       animations: { [weak self] in
                           guard let self = self else { return }
                           self.searchBarContainerView.snp.updateConstraints { make in
                               make.bottomMargin.equalTo(LayoutMetrics.searchBarClosedBottomOffset)
                           }
                           self.searchBar.showsCancelButton = false

                           self.view.layoutIfNeeded()
                       }, completion: { finished in
                           if finished {}
                       })
    }

    // MARK: - Private methods

    private func setupViews() {
        definesPresentationContext = true

        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = mapAdapter
    }

    private func setupDelegates() {
        locationAdapter.delegate = self
        mapAdapter.delegate = self
        searchBar.delegate = self
    }

    private func setupHierarchy() {
        view.addSubview(mapView)
        view.addSubview(addButton)
        view.addSubview(locationButton)
        view.addSubview(searchBarContainerView)
        searchBarContainerView.addSubview(searchBar)
    }

    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchBarContainerView.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview()
                .offset(LayoutMetrics.searchBarClosedBottomOffset)
            make.leadingMargin.equalToSuperview()
                .offset(LayoutMetrics.searchBarLeadingOffset)
            make.trailingMargin.equalToSuperview()
                .offset(LayoutMetrics.trailingOffset)
        }

        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
                .offset(LayoutMetrics.addButtonTopOffset)
            make.trailingMargin.equalToSuperview()
                .offset(LayoutMetrics.trailingOffset)
        }

        locationButton.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom)
                .offset(LayoutMetrics.buttonDistance)
            make.trailingMargin.equalToSuperview()
                .offset(LayoutMetrics.trailingOffset)
        }
    }

    // MARK: - Present child modals methods

    private func presentAddMenuModal() {
        let menuVC = AddMenuViewController()
        modalPresentationStyle = .overCurrentContext
        menuVC.modalDelegate = self
        present(menuVC, animated: true, completion: {})
    }

    private func presentAddLocationModal(_ selectedLocationType: MapPinType) {
        let locationVC: AddLocationFormsController = .init(locationType: selectedLocationType)

        if let lastKnownLocation = getUserLocation() {
            locationVC.setLastKnownLocation(lastKnownLocation)
        } else {
            // FIXME: avoid this
            fatalError("could not update users last known location")
        }

        modalPresentationStyle = .overCurrentContext
        present(locationVC, animated: true)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 1000
        static let resultsViewAnimationDuration: TimeInterval = 0.2
        static let searchBarClosedBottomOffset: CGFloat = -30
        static let searchBarOpenBottomOffset: CGFloat = 30
        static let searchBarLeadingOffset: CGFloat = 5
        static let searchBarInteractionAnimationDuration: TimeInterval = 0.2
        static let trailingOffset: CGFloat = -5
        static let addButtonTopOffset: CGFloat = 15
        static let buttonDistance: CGFloat = 5
    }
}

extension MapViewController: LocationAdapterDelegate, MapAdapterDelegate {
    func didLocateUser() { mapView.showsUserLocation = true }

    func willLocateUser() {
        guard let location = locationAdapter.currentLocation else { return }

        mapView.setRegion(MKCoordinateRegion(center: location.coordinate,
                                             latitudinalMeters: LayoutMetrics.centeringRegionRadius,
                                             longitudinalMeters: LayoutMetrics.centeringRegionRadius), animated: true)
    }

    func getUserLocation() -> CLLocation? {
        guard let location = locationAdapter.currentLocation else { return nil }

        return location
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
        closeSearchBar()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: Update search results
        searchBar.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        openSearchBar()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        closeSearchBar()
    }
}

extension MapViewController: ModalViewControllerDelegate {
    func sendValue(selectedType: MapPinType) {
        presentAddLocationModal(selectedType)
    }
}
