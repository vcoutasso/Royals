//
//  AddOptionView.swift
//  Skatable
//
//  Created by Vinícius Couto on 02/09/21.
//

import UIKit

final class AddOptionView: UIButton {
    // MARK: - Private variables

    private let iconName: String
    private let type: MapPinType
    private var action: () -> Void

    // MARK: - Initialization

    init(iconName: String, type: MapPinType, action: @escaping (() -> Void)) {
        self.iconName = iconName
        self.type = type
        self.action = action

        super.init(frame: .zero)

        setupView()
        setupConstraints()

        addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }

    // MARK: - Private methods

    private func setupView() {
        let font = UIFont.systemFont(ofSize: LayoutMetrics.iconFontSize, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)

        var icon = UIImage(systemName: iconName, withConfiguration: configuration)

        switch type {
        case .skateSpot:
            icon = icon?.imageWithColor(color: Assets.Colors.green.color)
            setTitle(Strings.Localizable.MapView.AddMenu.SkateSpot.title, for: .normal)
        case .skateStopper:
            icon = icon?.imageWithColor(color: Assets.Colors.red.color)
            setTitle(Strings.Localizable.MapView.AddMenu.SkateStopper.title, for: .normal)
        }

        backgroundColor = Assets.Colors.darkSystemGray4.color
        setImage(icon, for: .normal)
        target(forAction: #selector(tap), withSender: nil)
        layer.cornerRadius = LayoutMetrics.backgroundRectCornerRadius
    }

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.size.equalTo(LayoutMetrics.backgroundRectSize)
        }
    }

    @objc private func tap() {
        action()
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        private static let rectWidth: CGFloat = 294
        private static let rectHeight: CGFloat = 72

        static let backgroundRectSize = CGSize(width: rectWidth, height: rectHeight)
        static let backgroundRectCornerRadius: CGFloat = 36
        static let iconFontSize: CGFloat = 24
        static let iconFontWeight: UIFont.Weight = .bold
    }
}
