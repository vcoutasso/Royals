//
//  SearchResultsHeaderView.swift
//  Skatable
//
//  Created by Vinícius Couto on 06/09/21.
//

import UIKit

class SearchResultsHeaderView: UIStackView {
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        // Label
        let viewTitleLabel = UILabel()
        viewTitleLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: LayoutMetrics.viewTitleFontSize)
        viewTitleLabel.text = Strings.Localizable.MapScene.SearchResults.title

        // Current location item
        let locationMarker = UIImageView(image: UIImage(asset: Assets.Images.userLocationMarker))
        locationMarker.contentMode = .scaleAspectFit
        let subtitleText = UILabel()
        subtitleText.text = Strings.Localizable.MapScene.SearchResults.subtitle
        subtitleText.font = UIFont.systemFont(ofSize: LayoutMetrics.itemTitleFontSize, weight: .bold)
        subtitleText.textColor = Assets.Colors.yellow.color
        subtitleText.textAlignment = .center

        // Hstack
        let subtitleItem = UIStackView(arrangedSubviews: [locationMarker, subtitleText])
        subtitleItem.axis = .horizontal
        subtitleItem.alignment = .leading
        subtitleItem.spacing = LayoutMetrics.itemImageToTextDistance

        // Align text to center of the image
        subtitleText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
                .offset(-subtitleText.font.pointSize / 2)
        }

        addArrangedSubview(viewTitleLabel)
        addArrangedSubview(subtitleItem)
        self.axis = .vertical
        self.alignment = .leading
        self.spacing = LayoutMetrics.stackViewSpacing
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let viewTitleFontSize: CGFloat = 22
        static let itemTitleFontSize: CGFloat = 16
        static let itemImageToTextDistance: CGFloat = 30
        static let stackViewSpacing: CGFloat = 20
    }
}
