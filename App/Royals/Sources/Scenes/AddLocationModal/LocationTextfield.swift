//
//  LocationTextfield.swift
//  Skatable
//
//  Created by Bruno Thuma on 13/09/21.
//

import UIKit

class LocationTextField: UIView {
    private var baseTextField: DescriptionAndIconTextField

    init(theme: MapPinType) {
        self.baseTextField = DescriptionAndIconTextField(iconName: Strings.Names.Icons.location,
                                                         descriptionLabelText: Strings.Localizable.MapScene
                                                             .AddLocationForm
                                                             .location,
                                                         placeholderText: Strings.Localizable.MapScene.AddLocationForm
                                                             .locationPlaceholder,
                                                         theme: theme)

        super.init(frame: .zero)

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    private func setupViews() {
        baseTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        baseTextField.layer.cornerRadius = LayoutMetrics.generalCornerRadius
    }

    private func setupHierarchy() {
        addSubview(baseTextField)
    }

    private func setupConstraints() {
        baseTextField.snp.makeConstraints { make in
            make.height.equalTo(42)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
