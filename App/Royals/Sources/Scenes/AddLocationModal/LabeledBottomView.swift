//
//  LabeledBottomView.swift
//  Royals
//
//  Created by Bruno Thuma on 13/09/21.
//

import UIKit

class LabeledBottomView: UIView {
    private var theme: UIColor
    private var icon: UIImageView
    private var label: UILabel
    private var hStack: UIStackView
    var bottomView: UIView

    init(iconName: String, labelText: String, theme: UIColor) {
        if let image = UIImage(systemName: iconName) {
            self.icon = UIImageView(image: image)
        } else {
            self.icon = UIImageView(image: UIImage(systemName: "questionmark"))
        }

        self.theme = theme
        self.label = UILabel(frame: .zero)
        self.hStack = UIStackView(frame: .zero)
        self.bottomView = UIView()

        super.init(frame: .zero)

        backgroundColor = Assets.Colors.darkSystemGray5.color

        label.text = labelText

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    private func setupViews() {
        let iconsConfig = UIImage.SymbolConfiguration(pointSize: LayoutMetrics.iconsFontSize)

        label.font = LayoutMetrics.labelsFont
        label.textColor = Assets.Colors.white.color

        icon.preferredSymbolConfiguration = iconsConfig
        icon.image!.withTintColor(Assets.Colors.black.color)
        icon.image!.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.black
        icon.backgroundColor = theme
        icon.layer.cornerRadius = 5

        hStack = UIStackView(arrangedSubviews: [icon, label])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.backgroundColor = Assets.Colors.darkSystemGray5.color
        hStack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        hStack.layer.cornerRadius = LayoutMetrics.generalCornerRadius

        bottomView.backgroundColor = Assets.Colors.darkSystemGray5.color
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.cornerRadius = LayoutMetrics.generalCornerRadius
    }

    private func setupHierarchy() {
        addSubview(hStack)
        addSubview(bottomView)
    }

    private func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }

        label.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp_trailingMargin).offset(5)
        }

        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(42)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        bottomView.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp_bottomMargin)
            make.height.equalTo(100)
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
