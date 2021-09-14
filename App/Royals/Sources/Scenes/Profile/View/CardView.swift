//
//  CardView.swift
//  Royals
//
//  Created by Vinícius Couto on 14/09/21.
//

import UIKit

class CardView: UIView {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Assets.Colors.darkSystemGray5.color
        layer.cornerRadius = LayoutMetrics.cornerRadius
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func userCard(name: String) -> CardView {
        let card = CardView()

        let settings = UIButton()
        settings.backgroundColor = Assets.Colors.yellow.color
        settings.layer.cornerRadius = LayoutMetrics.settingsButtonCornerRadius
        let configuration = UIImage.SymbolConfiguration(pointSize: LayoutMetrics.buttonIconFontSize, weight: .bold)
        // FIXME: Button not glowing properly when highlighted
        settings.setImage(UIImage(systemName: Strings.Names.Icons.settings, withConfiguration: configuration),
                          for: .normal)
        settings.tintColor = .black

        let image = UIImageView(image: Assets.Images.dummyUserImage.image)
        image.makeRounded()

        card.addSubview(settings)
        card.addSubview(image)

        settings.snp.makeConstraints { make in
            make.size.equalTo(LayoutMetrics.buttonBackgroundRectSize)
            make.topMargin.equalTo(card.snp.topMargin)
                .offset(LayoutMetrics.settingsButtonOffset)
            make.rightMargin.equalTo(card.snp.rightMargin)
                .offset(-LayoutMetrics.settingsButtonOffset)
        }

        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(settings.snp.centerY)
        }

        return card
    }

    // MARK: - Laayout Metrics

    private enum LayoutMetrics {
        private static let rectSize: CGFloat = 32

        static let buttonBackgroundRectSize = CGSize(width: rectSize, height: rectSize)
        static let buttonIconFontSize: CGFloat = 16
        static let cornerRadius: CGFloat = 8
        static let profilePictureRadius: CGFloat = 31
        static let settingsButtonOffset: CGFloat = 10
        static let settingsButtonCornerRadius: CGFloat = 6
    }
}
