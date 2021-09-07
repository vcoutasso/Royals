//
//  MapViewController.swift
//  Skatable
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
    private lazy var searchResultsController: SearchResultsViewController = .init()
    private lazy var searchController: UISearchController = .init(searchResultsController: searchResultsController)

    private lazy var addButton: MapButtonView = .init(iconName: Strings.Names.Icons.add, action: presentAddMenuModal)
    private lazy var locationButton: MapButtonView = .init(iconName: Strings.Names.Icons.location,
                                                           action: willLocateUser)

    private var isPresentingResults: Bool = false

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
                           self.searchBar.alpha = 0
                           self.searchController.searchBar.alpha = 1

                           self.view.layoutIfNeeded()
                       }, completion: { finished in
                           if finished {
                               self.searchController.searchBar.searchBarStyle = .default
                               self.isPresentingResults = true
                               self.present(self.searchController, animated: true)
                               self.searchController.isActive = true
                           }
                       })
    }

    private func closeSearchBar() {
        searchController.searchBar.searchBarStyle = .minimal
        UIView.animate(withDuration: LayoutMetrics.searchBarInteractionAnimationDuration,
                       delay: 0,
                       options: [.curveLinear]) { [weak self] in
            guard let self = self else { return }
            self.searchBarContainerView.snp.updateConstraints { make in
                make.bottomMargin.equalTo(LayoutMetrics.searchBarClosedBottomOffset)
            }
            self.searchBar.alpha = 1
            self.searchController.searchBar.alpha = 0

            self.view.layoutIfNeeded()
        }
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

        searchController.modalPresentationStyle = .formSheet

        searchController.searchBar.alpha = 0
        searchController.searchBar.placeholder = Strings.Localizable.MapScene.SearchBar.placeholder
        searchController.searchBar.searchTextField.backgroundColor = Assets.Colors.darkSystemGray5.color
        searchController.searchBar.searchTextField.textColor = Assets.Colors.darkSystemGray1.color
        searchController.searchBar.searchTextField.leftView?.tintColor = Assets.Colors.darkSystemGray1.color
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barTintColor = .black
    }

    private func setupDelegates() {
        locationAdapter.delegate = self
        mapAdapter.delegate = self
        searchBar.delegate = self
        searchController.delegate = self
    }

    private func setupHierarchy() {
        view.addSubview(mapView)
        view.addSubview(addButton)
        view.addSubview(locationButton)
        view.addSubview(searchBarContainerView)
        searchBarContainerView.addSubview(searchBar)
        searchBarContainerView.addSubview(searchController.searchBar)
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

    private func presentAddMenuModal() {
        let menuVC = AddMenuViewController()
        modalPresentationStyle = .overCurrentContext
        present(menuVC, animated: true, completion: {})
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let centeringRegionRadius: CLLocationDistance = 1000
        static let searchBarClosedBottomOffset: CGFloat = -30
        static let searchBarOpenBottomOffset: CGFloat = 30
        static let searchBarLeadingOffset: CGFloat = 5
        static let searchBarInteractionAnimationDuration: TimeInterval = 0.3
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
}

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !isPresentingResults {
            searchBar.text = ""
            closeSearchBar()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if !isPresentingResults {
            openSearchBar()
        }
    }
}

extension MapViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        isPresentingResults = false
        searchBar.endEditing(true)
    }
}
