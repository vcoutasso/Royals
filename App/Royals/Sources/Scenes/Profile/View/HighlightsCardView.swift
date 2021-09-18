//
//  HighlightsCardView.swift
//  Royals
//
//  Created by Vinícius Couto on 14/09/21.
//

import UIKit

class HighlightsCardView: UIView {
    // MARK: - Private attributes

    private var starAttachment = NSTextAttachment(image: UIImage(systemName: Strings.Names.Icons.star)!)

    private lazy var spotImage: UIImageView = {
        UIImageView(image: UIImage(asset: Assets.Images.skateSpot))
    }()

    private lazy var skateImage: UIImageView = {
        UIImageView(image: UIImage(asset: Assets.Images.crownSkate))
    }()

    private lazy var favoriteSpot: UIStackView = {
        let title = UILabel()
        title.text = "Picos favoritos"
        title.font = .systemFont(ofSize: LayoutMetrics.descriptionFontSize, weight: .light)
        title.textColor = Assets.Colors.lightGray.color

        let descriptionText = NSMutableAttributedString(attachment: starAttachment)
        descriptionText.append(NSAttributedString(string: " " + "Pista Skate Ambiental"))
        let description = UILabel()
        description.attributedText = descriptionText
        description.font = .systemFont(ofSize: LayoutMetrics.descriptionFontSize, weight: .semibold)
        description.textColor = Assets.Colors.lightGray.color

        let stack = UIStackView(arrangedSubviews: [title, description])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = LayoutMetrics.descriptionStackSpacing

        return stack
    }()

    private lazy var favoriteTrick: UIStackView = {
        let title = UILabel()
        title.text = "Manobras favoritas"
        title.font = .systemFont(ofSize: LayoutMetrics.descriptionFontSize, weight: .light)
        title.textColor = Assets.Colors.lightGray.color

        let descriptionText = NSMutableAttributedString(attachment: starAttachment)
        descriptionText.append(NSAttributedString(string: " " + "360 Ollie"))
        let description = UILabel()
        description.attributedText = descriptionText
        description.font = .systemFont(ofSize: LayoutMetrics.descriptionFontSize, weight: .semibold)
        description.textColor = Assets.Colors.lightGray.color

        let stack = UIStackView(arrangedSubviews: [title, description])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = LayoutMetrics.descriptionStackSpacing

        return stack
    }()

    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = Assets.Colors.darkGray.color

        return separator
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = Assets.Colors.darkSystemGray5.color
        layer.cornerRadius = LayoutMetrics.cornerRadius
    }

    private func setupHierarchy() {
        addSubview(spotImage)
        addSubview(favoriteSpot)
        addSubview(separator)
        addSubview(skateImage)
        addSubview(favoriteTrick)
    }

    private func setupConstraints() {
        spotImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
                .multipliedBy(LayoutMetrics.leftImageCenterXMultiplicator)
            make.centerY.equalToSuperview()
                .offset(LayoutMetrics.imageCenterYOfsset)
        }

        favoriteSpot.snp.makeConstraints { make in
            make.centerX.equalTo(spotImage)
            make.topMargin.equalTo(spotImage.snp.bottomMargin)
                .offset(LayoutMetrics.descriptionTopOffset)
        }

        separator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(LayoutMetrics.separatorWidth)
            make.height.equalTo(snp.height)
                .multipliedBy(LayoutMetrics.separatorHeightMultiplier)
        }

        skateImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
                .multipliedBy(LayoutMetrics.rightImageCenterXMultiplicator)
            make.centerY.equalToSuperview()
                .offset(LayoutMetrics.imageCenterYOfsset)
        }

        favoriteTrick.snp.makeConstraints { make in
            make.centerX.equalTo(skateImage)
            make.centerY.equalTo(favoriteSpot)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let cornerRadius: CGFloat = 8
        static let leftImageCenterXMultiplicator: CGFloat = 0.5
        static let rightImageCenterXMultiplicator: CGFloat = 1.5
        static let imageCenterYOfsset: CGFloat = -20
        static let descriptionTopOffset: CGFloat = 30
        static let separatorWidth: CGFloat = 2
        static let separatorHeightMultiplier: CGFloat = 0.8
        static let descriptionFontSize: CGFloat = 10
        static let descriptionStackSpacing: CGFloat = 3
    }
}
