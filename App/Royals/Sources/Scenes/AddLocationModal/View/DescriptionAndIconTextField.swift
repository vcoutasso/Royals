//
//  DescriptionAndIconTextField.swift
//  Skatable
//
//  Created by Bruno Thuma on 11/09/21.
//

import UIKit

class DescriptionAndIconTextField: UITextField {
    private var descriptionText, placeholderText: String
    private var iconStack: UIStackView
    private var icon: UIImageView
    private var descriptionLabel: UILabel
    private var themeColor: UIColor

    init(iconName: String, descriptionLabelText: String, placeholderText: String, theme: MapPinType) {
        self.themeColor = {
            switch theme {
            case .skateSpot:
                return Assets.Colors.green.color
            case .skateStopper:
                return Assets.Colors.red.color
            }
        }()

        if let image = UIImage(systemName: iconName) {
            self.icon = UIImageView(image: image)
        } else {
            self.icon = UIImageView(image: UIImage(systemName: "questionmark"))
        }

        self.descriptionLabel = UILabel(frame: .zero)
        self.iconStack = UIStackView(frame: .zero)
        self.descriptionText = descriptionLabelText
        self.placeholderText = placeholderText

        super.init(frame: .zero)

        backgroundColor = Assets.Colors.darkSystemGray6.color

        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let iconsConfig = UIImage.SymbolConfiguration(pointSize: LayoutMetrics.iconsFontSize)

        descriptionLabel.text = descriptionText
        descriptionLabel.font = LayoutMetrics.labelsFont
        descriptionLabel.textColor = Assets.Colors.white.color

        icon.image!.withTintColor(Assets.Colors.black.color)
        icon.image!.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.black
        icon.backgroundColor = themeColor
        icon.contentMode = .scaleAspectFit
        icon.layer.cornerRadius = 5
        icon.preferredSymbolConfiguration = iconsConfig

        iconStack = UIStackView(arrangedSubviews: [icon, descriptionLabel])
        iconStack.axis = .horizontal
        iconStack.alignment = .center

        placeholder = placeholderText
        text = Strings.Localizable.MapScene.AddLocationForm.namePlaceholder
        backgroundColor = Assets.Colors.darkSystemGray5.color
        textColor = Assets.Colors.darkGray.color
        leftViewMode = .always
        leftView = iconStack
        font = LayoutMetrics.labelsFont
        layer.cornerRadius = LayoutMetrics.generalCornerRadius
    }

    private func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailingMargin).offset(5)
//            make.trailing.equalToSuperview().offset(20)
        }
    }

    private enum LayoutMetrics {
        static let labelsFont = UIFont.systemFont(ofSize: 16)

        static let generalCornerRadius: CGFloat = 8

        static let titleToNameTopPadding: CGFloat = 50

        static let iconsFontSize: CGFloat = 12
    }
}