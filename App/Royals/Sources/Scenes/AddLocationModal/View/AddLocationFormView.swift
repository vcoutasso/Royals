//
//  AddPinFormView.swift
//  Skatable
//
//  Created by Bruno Thuma on 08/09/21.
//

import MapKit
import UIKit

class AddLocationFormView: UIView {
    private var theme: UIColor
    private var addLocationButton: UIButton
    private var addLocationButtonAction: () -> Void
    private var title: MultiatributedLabelView
    private var nameTextField: DescriptionAndIconTextField
    private var locationTextField: DescriptionAndIconTextField
    private var photosField: LabeledBottomView
    private var photosCarrousselView: UIView
    private var descriptionField: LabeledBottomView
    private var descriptionTextView: UITextView

    var mapView: MKMapView

    // MARK: - Contructor

    init(theme: MapPinType, createAction: @escaping () -> Void) {
        self.theme = {
            switch theme {
            case .skateSpot:
                return Assets.Colors.green.color
            case .skateStopper:
                return Assets.Colors.red.color
            }
        }()

        self.addLocationButtonAction = createAction

        self.addLocationButton = UIButton(type: .system)

        self.title = MultiatributedLabelView(theme: theme)

        self.nameTextField = DescriptionAndIconTextField(iconName: Strings.Names.Icons.nameField,
                                                         descriptionLabelText: Strings.Localizable.MapScene
                                                             .AddLocationForm.name,
                                                         placeholderText: Strings.Localizable.MapScene.AddLocationForm
                                                             .namePlaceholder,
                                                         theme: theme)

        self.locationTextField = DescriptionAndIconTextField(iconName: Strings.Names.Icons.location,
                                                             descriptionLabelText: Strings.Localizable.MapScene
                                                                 .AddLocationForm.location,
                                                             placeholderText: Strings.Localizable.MapScene
                                                                 .AddLocationForm.locationPlaceholder,
                                                             theme: theme)

        self.mapView = MKMapView()

        self.photosField = LabeledBottomView(iconName: Strings.Names.Icons.photo,
                                             labelText: Strings.Localizable.MapScene.AddLocationForm.photos,
                                             theme: self.theme)

        self.photosCarrousselView = UIView()

        self.descriptionField = LabeledBottomView(iconName: Strings.Names.Icons.skateSpotFilless,
                                                  labelText: Strings.Localizable.MapScene.AddLocationForm.description,
                                                  theme: self.theme)

        self.descriptionTextView = UITextView()

        super.init(frame: .zero)

        backgroundColor = Assets.Colors.darkSystemGray6.color

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func getName() -> String {
        return nameTextField.text ?? ""
    }

    func getLocation() -> CLLocation {
        return mapView.userLocation.location!
    }

    func getDescription() -> String {
        return descriptionTextView.text ?? ""
    }

    // MARK: - Private methods

    private func setupViews() {
        addLocationButton.setTitle("Criar", for: .normal)
        addLocationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        addLocationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        title.textAlignment = .left
        title.numberOfLines = -1

        locationTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        locationTextField.layer.cornerRadius = LayoutMetrics.generalCornerRadius

        mapView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mapView.layer.cornerRadius = LayoutMetrics.generalCornerRadius

        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = false

        photosCarrousselView.backgroundColor = Assets.Colors.darkSystemGray5.color
        photosCarrousselView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        photosCarrousselView.layer.cornerRadius = LayoutMetrics.generalCornerRadius

        descriptionTextView.backgroundColor = Assets.Colors.darkSystemGray5.color
        descriptionTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        descriptionTextView.layer.cornerRadius = LayoutMetrics.generalCornerRadius
        descriptionTextView.font = UIFont.systemFont(ofSize: 15)
        descriptionTextView.isEditable = true
    }

    private func setupHierarchy() {
        addSubview(addLocationButton)
        addSubview(title)
        addSubview(nameTextField)
        addSubview(locationTextField)
        addSubview(mapView)
        addSubview(photosField)
        addSubview(photosCarrousselView)
        addSubview(descriptionField)
        addSubview(descriptionTextView)
    }

    private func setupConstraints() {
        addLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }

        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutMetrics.generalTopPadding)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(title.snp_bottomMargin).offset(LayoutMetrics.generalItemsSpacing)
            make.height.equalTo(42)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
        }

        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp_bottomMargin).offset(LayoutMetrics.generalItemsSpacing)
            make.height.equalTo(42)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
        }

        mapView.snp.makeConstraints { make in
            make.topMargin.equalTo(locationTextField.snp_bottomMargin).offset(8)
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
        }

        photosField.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp_bottomMargin).offset(LayoutMetrics.generalItemsSpacing)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
        }

        photosCarrousselView.snp.makeConstraints { make in
            make.top.equalTo(photosField.snp_bottomMargin).offset(LayoutMetrics.generalItemsSpacing)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(120)
        }

        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(photosCarrousselView.snp_bottomMargin).offset(LayoutMetrics.generalItemsSpacing)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionField.snp_bottomMargin).offset(LayoutMetrics.generalItemsSpacing)
            make.leading.trailing.equalToSuperview().inset(LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(120)
        }
    }

    @objc private func buttonTapped() {
        addLocationButtonAction()
    }

    // TODO: All *Location*View.swift have LayoutMetrics, maybe define a public enum
    private enum LayoutMetrics {
        static let textFontSize: CGFloat = 25
        static let labelsFont = UIFont.systemFont(ofSize: 16)

        static let generalCornerRadius: CGFloat = 8

        static let generalTopPadding: CGFloat = 20
        static let generalHorizontalPadding: CGFloat = 20

        static let generalItemsSpacing: CGFloat = 42

        static let iconsFontSize: CGFloat = 12
    }
}
