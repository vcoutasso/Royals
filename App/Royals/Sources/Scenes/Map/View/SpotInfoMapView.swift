//
//  SpotInfoMapView.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 08/09/21.
//

import UIKit

final class SpotInfoMapView: UIView {
    // MARK: - Private variables

    private var carouselView: CarouselView = .init()
    private var carouselData = [CarouselView.CarouselData]()

    private let type: MapPinType
    private let title: String
    private let distance: String
    private let rating: Float?
    private let descriptionStopper: String?
    private let quantityRating: Int?
    private let address: String
    private let images: [UIImage]

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
    private var separator2 = SeparatorView()
    private var separator3 = SeparatorView()
    private var tableView: OptionInfoMapTableView

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
        self.separator2 = .init(frame: CGRect(x: .zero, y: .zero, width: LayoutMetrics.separatorWidth, height: 2))
        self.separator3 = .init(frame: CGRect(x: .zero, y: .zero, width: LayoutMetrics.separatorWidth, height: 2))
        self.tableView = .init(type: type)

        super.init(frame: .zero)

        setupView()
        setupHierarchy()
        setupConstraints()
        carouselView.configureView(with: carouselData)
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
                    NSAttributedString.Key.font: UIFont
                        .systemFont(ofSize: LayoutMetrics.ratingFontSize,
                                    weight: .bold),
                    NSAttributedString.Key.foregroundColor: Assets.Colors.yellow.color,
                ])

        attributedText.append(NSAttributedString(string: "(\(String(describing: quantityRating!)))", attributes:
            [
                NSAttributedString.Key.font: UIFont
                    .systemFont(ofSize: LayoutMetrics.ratingFontSize,
                                weight: .light),
                NSAttributedString.Key.foregroundColor: Assets.Colors
                    .darkSystemGray1.color,
            ]))

        titleLabel.text = title
        titleLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: LayoutMetrics.titleFontSize)

        spotLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.distanceFontSize, weight: .regular)

        descriptionLabel.text = descriptionStopper
        descriptionLabel.textColor = Assets.Colors.darkSystemGray1.color
        descriptionLabel.numberOfLines = -1
        addressInfoLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.contentMode = .scaleToFill
        descriptionLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.distanceFontSize, weight: .medium)

        ratingIcon.image = UIImage(systemName: Strings.Names.Icons.star,
                                   withConfiguration: configuration)!.imageWithColor(color: Assets.Colors.yellow.color)
        ratingIcon.contentMode = .scaleAspectFit
        ratingLabel.attributedText = attributedText
        ratingLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.optionsFontSize)
        ratingStackView = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])
        ratingStackView.alignment = .leading

        feedIcon = (UIImage(systemName: Strings.Names.Icons.houseFill, withConfiguration: configuration)!
            .imageWithColor(color: Assets.Colors.green.color))!
        buttonFeed.setTitle("Ver feed", for: .normal)
        buttonFeed.setImage(feedIcon, for: .normal)
        buttonFeed.titleLabel?.font = UIFont.systemFont(ofSize: LayoutMetrics.optionsFontSize, weight: .semibold)
        buttonFeed.setTitleColor(Assets.Colors.green.color, for: .normal)
        buttonFeed.contentHorizontalAlignment = .leading

        addressLabel.text = "Endereço"
        addressLabel.textColor = Assets.Colors.darkSystemGray1.color
        addressInfoLabel.text = address
        addressInfoLabel.numberOfLines = 4
        addressInfoLabel.font = UIFont.systemFont(ofSize: LayoutMetrics.addressInfoFontSize, weight: .regular)

        switch type {
        case .skateSpot:
            spotLabel.text = "Pico - \(distance)"

        case .skateStopper:
            spotLabel.text = "Stopper - \(distance)"
        }

        for img in images {
            carouselData.append(.init(image: img))
        }

        //        axis = .vertical
        //        alignment = .leading
        //        spacing = 20
        backgroundColor = LayoutMetrics.backgroundColor
    }

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(spotLabel)
        if type == .skateSpot {
            addSubview(ratingStackView)
            addSubview(buttonFeed)
        }
        if type == .skateStopper {
            addSubview(descriptionLabel)
        }

        addSubview(separator)
        addSubview(addressLabel)
        addSubview(addressInfoLabel)
        addSubview(separator2)
        addSubview(carouselView)
        addSubview(separator3)
        addSubview(tableView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutMetrics.generalTopPadding).labeled("title")
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(22)
        }

        spotLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(LayoutMetrics.spotTop)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(22)
        }

        if type == .skateStopper {
            descriptionLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
                make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
                make.top.equalTo(spotLabel.snp.bottom).offset(LayoutMetrics.descriptionTop)
                // make.height.equalTo(70)
            }
        }

        if type == .skateSpot {
            ratingStackView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
                make.trailing.equalToSuperview().offset(-248)
                make.top.equalTo(spotLabel.snp.bottom).offset(LayoutMetrics.ratingTop)
                make.height.equalTo(LayoutMetrics.ratingHeight)
            }

            buttonFeed.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
                make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
                make.top.equalTo(ratingStackView.snp.bottom).offset(LayoutMetrics.buttonFeedTop)
                make.height.equalTo(LayoutMetrics.buttonFeedHeight)
            }
        }

        separator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(1)
            switch type {
            case .skateSpot:
                make.top.equalTo(buttonFeed.snp.bottom).offset(LayoutMetrics.separatorTop)
            case .skateStopper:
                make.top.equalTo(descriptionLabel.snp.bottom).offset(LayoutMetrics.separatorTop)
            }
        }

        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(22)
            make.top.equalTo(separator.snp.bottom).offset(LayoutMetrics.addressLabelTop)
        }
        //
        addressInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            // make.height.equalTo(88)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.addressTrailing)
            make.top.equalTo(addressLabel.snp.bottom).offset(LayoutMetrics.addressLabelInfoTop)
        }

        separator2.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.top.equalTo(addressInfoLabel.snp.bottom).offset(LayoutMetrics.separatorTop)
            make.height.equalTo(1)
        }
        //
        carouselView.snp.makeConstraints { make in
            make.height.equalTo(LayoutMetrics.heightCarosel)
            make.top.equalTo(separator2.snp.bottom).offset(LayoutMetrics.topCarosel)
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
        }

        separator3.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.generalHorizontalPadding)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.height.equalTo(1)
            make.top.equalTo(carouselView.snp.bottom).offset(LayoutMetrics.topCarosel)
            // make.bottom.equalTo(tableView.snp.top).offset(30)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(separator3.snp.bottom).offset(0)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.generalHorizontalPadding)
            make.leading.equalToSuperview()
            switch type {
            case .skateSpot:
                make.height.equalTo(LayoutMetrics.heightTableSpot)
            case .skateStopper:
                make.height.equalTo(LayoutMetrics.heightTableStopper)
            }
        }
    }
}

// MARK: - Layout Metrics

private enum LayoutMetrics {
    private static let rectWidth: CGFloat = 375
    private static let rectHeight: CGFloat = 752

    static let backgroundColor: UIColor = Assets.Colors.darkSystemGray5.color
    static let titleFontSize: CGFloat = 20
    static let titleBottom: CGFloat = -164
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

    static let spotTop: CGFloat = 2
    static let ratingTop: CGFloat = 3
    static let ratingHeight: CGFloat = 16
    static let descriptionTop: CGFloat = 13
    static let buttonFeedTop: CGFloat = 15
    static let buttonFeedHeight: CGFloat = 26
    static let addressLabelTop: CGFloat = 15
    static let addressLabelInfoTop: CGFloat = 2
    static let addressTrailing: CGFloat = 260
    static let separatorWidth: CGFloat = 347
    static let heightTableRow: CGFloat = 56
    static let heightTableSpot: CGFloat = heightTableRow * 4
    static let heightTableStopper: CGFloat = heightTableRow * 2
    static let heightCarosel: CGFloat = 150
    static let tableTop: CGFloat = 15
    static let topCarosel: CGFloat = 28
    static let separatorTop: CGFloat = 15
}
