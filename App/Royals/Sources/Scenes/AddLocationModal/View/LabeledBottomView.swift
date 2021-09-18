//
//  LabeledBottomView.swift
//  Skatable
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
        icon.contentMode = .scaleAspectFit
        icon.tintColor = UIColor.black
        icon.backgroundColor = theme
        icon.layer.cornerRadius = LayoutMetrics.iconCornerRadius

        hStack = UIStackView(arrangedSubviews: [icon, label])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.backgroundColor = Assets.Colors.darkSystemGray5.color
        hStack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        hStack.layer.cornerRadius = LayoutMetrics.generalCornerRadius
        hStack.spacing = LayoutMetrics.stackSpacing

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
            make.size.equalTo(LayoutMetrics.iconFrameSize)
            make.leading.equalToSuperview().inset(LayoutMetrics.stackInset)
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(LayoutMetrics.iconFrameSize)
        }

        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(LayoutMetrics.stackHeight)
            make.leading.trailing.equalToSuperview()
        }

        bottomView.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp_bottomMargin)
            make.height.equalTo(LayoutMetrics.bottomViewHeight)
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
        
        static let stackHeight: CGFloat = 42
        static let bottomViewHeight: CGFloat = 120

        static let generalCornerRadius: CGFloat = 8
        static let iconCornerRadius: CGFloat = 5

        static let generalTopPadding: CGFloat = 20
        static let generalHorizontalPadding: CGFloat = 20

        static let titleToNameTopPadding: CGFloat = 50

        static let iconsFontSize: CGFloat = 5
        
        static let stackSpacing: CGFloat = 10
        
        static let iconFrameSize: CGFloat = 22
        
        static let stackInset: CGFloat = 10
    }
}
