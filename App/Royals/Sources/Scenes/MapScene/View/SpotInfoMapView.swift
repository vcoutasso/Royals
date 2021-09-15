//
//  SpotInfoMapView.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 08/09/21.
//

import UIKit

final class SpotInfoMapView: UIStackView {
    // MARK: - Private variables

    private var carouselView: CarouselView = .init()
    static var carouselData = [CarouselView.CarouselData]()

    private let type: MapPinType
    private let title: String
    private let distance: String
    private let rating: Float?
    private let descriptionStopper: String?
    private let quantityRating: Int?
    private let address: String
    private let images: [UIImage]?

    private var titleLabel = UILabel()
    private var ratingIcon = UIImageView()
    private var ratingLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var spotLabel = UILabel()
    private var button = UIButton()
    private var addressLabel = UILabel()
    private var addressInfoLabel = UILabel()
    private var feedIcon = UIImage()
    private var buttonFeed = UIButton()
    private var ratingStackView = UIStackView()
    private var separator = SeparatorView()

    static var imagesList = [UIImage]()

    // MARK: - Initialization

    init(type: MapPinType, title: String, distance: String, rating: Float?, descriptionStopper: String?,
         quantityRating: Int?, address: String, images: [UIImage]) {
        self.type = type
        self.title = title
        self.distance = distance
        self.rating = rating
        self.descriptionStopper = descriptionStopper
        self.quantityRating = quantityRating
        self.address = address
        self.images = images
        self.titleLabel = UILabel(frame: .zero)
        self.ratingIcon = UIImageView(frame: .zero)
        self.spotLabel = UILabel(frame: .zero)
        self.descriptionLabel = UILabel(frame: .zero)
        self.button = UIButton(frame: .zero)
        self.addressLabel = UILabel(frame: .zero)
        self.addressInfoLabel = UILabel(frame: .zero)
        self.buttonFeed = UIButton(frame: .zero)
        self.feedIcon = UIImage()
        self.separator = .init(frame: CGRect(x: .zero, y: .zero, width: LayoutMetrics.separatorWidth, height: 2))

        super.init(frame: .zero)

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        let font = UIFont.systemFont(ofSize: LayoutMetrics.ratingFontSize, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let attributedText =
            NSMutableAttributedString(string: " \(String(describing: rating!))", attributes:
                [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: LayoutMetrics.ratingFontSize, weight: .bold),
                    NSAttributedString.Key.foregroundColor: Assets.Colors.yellow.color,
                ])

        attributedText.append(NSAttributedString(string: "(\(String(describing: quantityRating!)))", attributes:
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: LayoutMetrics.ratingFontSize, weight: .light),
                NSAttributedString.Key.foregroundColor: Assets.Colors.darkSystemGray1.color,
            ]))

        titleLabel.text = title
        titleLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: LayoutMetrics.titleFontSize)

        spotLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.distanceFontSize, weight: .regular)

        descriptionLabel.text = descriptionStopper
        descriptionLabel.textColor = Assets.Colors.darkSystemGray1.color
        descriptionLabel.numberOfLines = 2
        addressInfoLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.contentMode = .scaleToFill
        descriptionLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.distanceFontSize, weight: .medium)

        ratingIcon.image = UIImage(systemName: Strings.Names.Icons.star,
                                   withConfiguration: configuration)!.imageWithColor(color: Assets.Colors.yellow.color)
        ratingIcon.contentMode = .scaleAspectFit
        ratingLabel.attributedText = attributedText
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingStackView = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])

        feedIcon = (UIImage(systemName: Strings.Names.Icons.houseFill, withConfiguration: configuration)!
            .imageWithColor(color: Assets.Colors.green.color))!
        buttonFeed.setTitle("Ver feed", for: .normal)
        buttonFeed.setImage(feedIcon, for: .normal)
        buttonFeed.titleLabel?.font = UIFont.systemFont(ofSize: LayoutMetrics.optionsFontSize, weight: .semibold)
        buttonFeed.setTitleColor(Assets.Colors.green.color, for: .normal)

        addressLabel.text = "Endereço"
        addressLabel.textColor = Assets.Colors.darkSystemGray1.color
        addressInfoLabel.text = address
        addressInfoLabel.numberOfLines = 4
        addressInfoLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.addressInfoFontSize, weight: .regular)

        switch type {
        case .skateSpot:
            spotLabel.text = "Pico \(distance)"

        case .skateStopper:
            spotLabel.text = "Stopper \(distance)"
        }
        if images!.isEmpty {
            for img in images! {
                SpotInfoMapView.carouselData.append(.init(image: img))
            }
        }
        axis = .vertical
        alignment = .leading
        distribution = .fill
        backgroundColor = LayoutMetrics.backgroundColor
    }

    private func setupHierarchy() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(spotLabel)
        if type == .skateSpot {
            addArrangedSubview(ratingStackView)
            addArrangedSubview(buttonFeed)
        }
        if type == .skateStopper {
            addArrangedSubview(descriptionLabel)
        }

        addArrangedSubview(separator)
        addArrangedSubview(addressLabel)
        addArrangedSubview(addressInfoLabel)
        // self.addArrangedSubview(separator)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutMetrics.generalTopPadding)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
        }

        spotLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.top.equalToSuperview().offset(LayoutMetrics.spotTop)
        }

        if type == .skateStopper {
            descriptionLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
                make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
                make.top.equalToSuperview().offset(LayoutMetrics.descriptionTop)
            }
        }

        if type == .skateSpot {
            ratingStackView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
                make.top.equalToSuperview().offset(LayoutMetrics.ratingTop)
                make.bottom.equalToSuperview().offset(-LayoutMetrics.ratingBottom)
            }

            buttonFeed.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
                make.top.equalToSuperview().offset(LayoutMetrics.buttonFeedTop)
            }
        }

        separator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            switch type {
            case .skateSpot:
                make.top.equalTo(buttonFeed.snp.bottom).offset(LayoutMetrics.separatorTop)
                make.bottom.equalTo(addressLabel.snp.top).offset(LayoutMetrics.separatorBottomSpot)
            case .skateStopper:
                make.top.equalTo(descriptionLabel.snp.bottom).offset(LayoutMetrics.separatorTop)
                make.bottom.equalTo(addressLabel.snp.top).offset(LayoutMetrics.separatorBottom)
            }
        }

        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            switch type {
            case .skateSpot:
                make.top.equalToSuperview().offset(LayoutMetrics.addressLabelTopSpot)
            case .skateStopper:
                make.top.equalToSuperview().offset(LayoutMetrics.addressLabelTopStopper)
            }
        }

        addressInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.addressTrailing)
            switch type {
            case .skateSpot:
                make.top.equalToSuperview().offset(LayoutMetrics.addressLabelInfoTopSpot)
            case .skateStopper:
                make.top.equalToSuperview().offset(LayoutMetrics.addressLabelInfoTopStopper)
            }
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        private static let rectWidth: CGFloat = 375
        private static let rectHeight: CGFloat = 752

        static let backgroundColor: UIColor = Assets.Colors.darkSystemGray5.color
        static let titleFontSize: CGFloat = 20
        static let ratingFontSize: CGFloat = 14
        static let addressFontSize: CGFloat = 16
        static let distanceFontSize: CGFloat = 14
        static let buttonFontSize: CGFloat = 13
        static let buttonCornerRadius: CGFloat = 5
        static let addressInfoFontSize: CGFloat = 14
        static let optionsFontSize: CGFloat = 14
        static let iconsOptionsSize: CGFloat = 30
        static let generalTopPadding: CGFloat = 33
        static let generalHorizontalPadding: CGFloat = 15
        static let spotTop: CGFloat = 55
        static let ratingTop: CGFloat = 75
        static let ratingBottom: CGFloat = 674
        static let descriptionTop: CGFloat = 70
        static let buttonFeedTop: CGFloat = 100
        static let buttonSize: CGFloat = 50
        static let addressLabelTopSpot: CGFloat = 168
        static let addressLabelTopStopper: CGFloat = 168
        static let addressLabelInfoTopStopper: CGFloat = 195
        static let addressLabelInfoTopSpot: CGFloat = 198
        static let addressTrailing: CGFloat = 260
        static let separatorBottom: CGFloat = -23
        static let separatorBottomSpot: CGFloat = -7
        static let separatorWidth: CGFloat = 347
        static let separatorTop: CGFloat = 23
    }
}
