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
    private var title: MultiatributedLabelView
    private var nameTextField: UITextField
    private var locationTextField: LocationTextField
    private var photosField: LabeledBottomView
    private var descriptionField: LabeledBottomView

    var mapBottomView: UIView

    init(theme: MapPinType) {
        self.theme = {
            switch theme {
            case .skateSpot:
                return Assets.Colors.green.color
            case .skateStopper:
                return Assets.Colors.red.color
            }
        }()

        self.title = MultiatributedLabelView(theme: theme)

        self.nameTextField = DescriptionAndIconTextField(iconName: Strings.Names.Icons.nameField,
                                                         descriptionLabelText: Strings.Localizable.MapScene
                                                             .AddLocationForm.name,
                                                         placeholderText: Strings.Localizable.MapScene.AddLocationForm
                                                             .namePlaceholder,
                                                         theme: theme)

        self.locationTextField = LocationTextField(theme: theme)

        self.mapBottomView = UIView()

        self.photosField = LabeledBottomView(iconName: Strings.Names.Icons.photo,
                                             labelText: Strings.Localizable.MapScene.AddLocationForm.photos,
                                             theme: self.theme)

        self.descriptionField = LabeledBottomView(iconName: Strings.Names.Icons.skateSpotFilless,
                                                  labelText: Strings.Localizable.MapScene.AddLocationForm.description,
                                                  theme: self.theme)

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

    private func setupViews() {
        title.textAlignment = .left
        title.numberOfLines = -1

        mapBottomView.backgroundColor = Assets.Colors.darkSystemGray5.color
        mapBottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mapBottomView.layer.cornerRadius = LayoutMetrics.generalCornerRadius
    }

    private func setupHierarchy() {
        addSubview(title)
        addSubview(nameTextField)
        addSubview(locationTextField)
        addSubview(mapBottomView)
        addSubview(photosField)
        addSubview(descriptionField)
    }

    private func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutMetrics.generalTopPadding)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(title.snp_bottomMargin).offset(LayoutMetrics.titleToNameTopPadding)
            make.height.equalTo(42)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }

        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp_bottomMargin).offset(LayoutMetrics.titleToNameTopPadding)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }

        mapBottomView.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp_bottomMargin).offset(42)
            make.height.equalTo(100)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }

        photosField.snp.makeConstraints { make in
            make.top.equalTo(mapBottomView.snp_bottomMargin).offset(LayoutMetrics.titleToNameTopPadding)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }

        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(photosField.bottomView.snp_bottomMargin).offset(LayoutMetrics.titleToNameTopPadding)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }
    }

    private enum LayoutMetrics {
        static let textFontSize: CGFloat = 25
        static let labelsFont = UIFont.systemFont(ofSize: 16)

        static let generalCornerRadius: CGFloat = 8

        static let generalTopPadding: CGFloat = 20
        static let generalHorizontalPadding: CGFloat = 20

        static let titleToNameTopPadding: CGFloat = 50

        static let iconsFontSize: CGFloat = 12
    }
}

