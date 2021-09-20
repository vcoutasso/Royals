//
//  AvaliacaoDoPicoView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 18/09/21.
//

import UIKit

class SpotEvaluationView: UIView {
    private var profileImage = UIImageView()
    private var profileName: String
    private var nomeSpot: String

    private var imagePonintMap = UIImageView()
    private let rectangle = UIView()
    private let rectangleStars = UIView()
    private let rectangleText = UIView()
    private let separator: SeparatorView = .init()
    private let commentTextField: CommentTextFieldView = .init()

    private lazy var profileImage2: UIImageView = {
        UIImageView(image: UIImage(asset: Assets.Images.profileImage2))
    }()

    private lazy var profileImage3: UIImageView = {
        UIImageView(image: UIImage(asset: Assets.Images.profileImage3))
    }()

    init(profileImage: UIImageView, profileName: String, nomeSpot: String) {
        self.profileImage = profileImage
        self.profileName = profileName
        self.nomeSpot = nomeSpot

        super.init(frame: .zero)

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: mandar essa stack para outro arquivo pq repete na class CardComments
    private lazy var firstStack: UIStackView = {
        let name = UILabel()
        name.text = profileName
        name.font = .systemFont(ofSize: LayoutMetrics.nameFontSize, weight: .semibold)

        let spot = UILabel()
        spot.text = nomeSpot
        spot.font = .systemFont(ofSize: LayoutMetrics.spotFontSize, weight: .regular)
        spot.textColor = Assets.Colors.lightGray.color

        let font = UIFont.systemFont(ofSize: LayoutMetrics.imagePonintMapFontSize, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)

        imagePonintMap.image = UIImage(systemName: Strings.Names.Icons.mappinPont, withConfiguration: configuration)
        imagePonintMap.tintColor = Assets.Colors.lightGray.color
        imagePonintMap.contentMode = .scaleAspectFit

        let stackSpot = UIStackView(arrangedSubviews: [imagePonintMap, spot])
        stackSpot.axis = .horizontal
        stackSpot.alignment = .leading
        stackSpot.spacing = LayoutMetrics.stackSpotSpace

        let stackNameProfile = UIStackView(arrangedSubviews: [name, stackSpot])
        stackNameProfile.axis = .vertical
        stackNameProfile.alignment = .leading
        stackNameProfile.spacing = LayoutMetrics.stackNameProfileSpace

        profileImage.contentMode = .scaleAspectFill
        profileImage.frame.size = CGSize(width: LayoutMetrics.profileImageWidth,
                                         height: LayoutMetrics.profileImageWidth)
        profileImage.makeRoundedProfile()

        let stackProfile = UIStackView(arrangedSubviews: [profileImage, stackNameProfile])
        stackProfile.axis = .horizontal
        stackProfile.alignment = .center
        stackProfile.spacing = LayoutMetrics.stackProfileSpace

        profileImage.snp.makeConstraints { make in
            make.width.equalTo(LayoutMetrics.profileImageWidth)
            make.height.equalTo(LayoutMetrics.profileImageHeight)
        }

        return stackProfile

    }()

    // TODO: tem que fazer com que as estrelas sejam preenchidas de acordo com o usuário escolhe, por enquanto só foi colocado elas de forma estática
    private lazy var secondStack: UIStackView = {
        let star1: StarFillView = .init(colorTint: Assets.Colors.yellow.color, size: LayoutMetrics.starFontSize)
        let star2: StarOutlineView = .init(colorTint: Assets.Colors.yellow.color, size: LayoutMetrics.starFontSize)
        let star3: StarOutlineView = .init(colorTint: Assets.Colors.yellow.color, size: LayoutMetrics.starFontSize)
        let star4: StarOutlineView = .init(colorTint: Assets.Colors.yellow.color, size: LayoutMetrics.starFontSize)
        let star5: StarOutlineView = .init(colorTint: Assets.Colors.yellow.color, size: LayoutMetrics.starFontSize)

        var stackListStars = UIStackView(arrangedSubviews: [star1, star2, star3, star4, star5])
        stackListStars.axis = .horizontal
        stackListStars.alignment = .leading
        stackListStars.spacing = LayoutMetrics.stackListStars

        return stackListStars
    }()

    private lazy var thirdStack: UIStackView = {
        let title = UILabel()
        title.text = Strings.Localizable.MapScene.AvaliacaoDoPico.title
        title.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .regular)

        let number = UILabel()
        number.text = "400"
        number.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .regular)
        number.textColor = Assets.Colors.darkSystemGray2.color

        let stackLabel = UIStackView(arrangedSubviews: [title, number])
        stackLabel.axis = .horizontal
        stackLabel.alignment = .leading
        stackLabel.spacing = LayoutMetrics.stackLabelSpace

        return stackLabel

    }()

    private func setupView() {
        rectangle.backgroundColor = Assets.Colors.darkSystemGray5.color
        rectangle.layer.cornerRadius = LayoutMetrics.rectangleCornerRadius
        rectangle.layer.masksToBounds = true

        rectangleStars.backgroundColor = Assets.Colors.darkSystemGray5.color
        rectangleStars.layer.cornerRadius = LayoutMetrics.rectangleCornerRadius
        rectangleStars.layer.masksToBounds = true

        rectangleText.backgroundColor = Assets.Colors.darkSystemGray5.color
        rectangleText.layer.cornerRadius = LayoutMetrics.rectangleCornerRadius
        rectangleText.layer.masksToBounds = true
    }

    private func setupHierarchy() {
        addSubview(rectangle)
        addSubview(firstStack)
        addSubview(rectangleStars)
        addSubview(secondStack)
        addSubview(rectangleText)
        addSubview(separator)
        addSubview(thirdStack)
        addSubview(commentTextField)
    }

    private func setupConstraints() {
        rectangle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.geralLeading)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.geralLeading)
            make.top.equalToSuperview().offset(LayoutMetrics.rectangleTop1)
            make.height.equalTo(LayoutMetrics.rectangleHeight1)
        }

        firstStack.snp.makeConstraints { make in
            make.leading.equalTo(rectangle.snp.leading).offset(LayoutMetrics.firstStackLeading)
            make.trailing.equalTo(rectangle.snp.trailing).offset(-61)
            make.top.equalTo(rectangle.snp.top).offset(21)
            make.bottom.equalTo(rectangle.snp.bottom).offset(-21)
        }

        rectangleStars.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.geralLeading)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.geralLeading)
            make.top.equalTo(rectangle.snp.bottom).offset(16)
            make.height.equalTo(58)
        }

        secondStack.snp.makeConstraints { make in
            make.leading.equalTo(rectangleStars.snp.leading).offset(21)
            make.trailing.equalTo(rectangleStars.snp.trailing).offset(-21)
            make.top.equalTo(rectangleStars.snp.top).offset(18)
            make.bottom.equalTo(rectangleStars.snp.bottom).offset(-18)
        }

        rectangleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutMetrics.geralLeading)
            make.trailing.equalToSuperview().offset(-LayoutMetrics.geralLeading)
            make.top.equalTo(rectangleStars.snp.bottom).offset(16)
            make.height.equalTo(154)
        }

        thirdStack.snp.makeConstraints { make in
            make.leading.equalTo(rectangleStars.snp.leading).offset(14)
            make.trailing.equalTo(rectangleStars.snp.trailing).offset(-20)
            make.top.equalTo(rectangleText.snp.top).offset(13)
        }

        separator.snp.makeConstraints { make in
            make.leading.equalTo(rectangleStars.snp.leading)
            make.trailing.equalTo(rectangleStars.snp.trailing)
            make.top.equalTo(rectangleText.snp.top).offset(41)
            make.height.equalTo(0.5)
        }

        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(rectangleStars.snp.leading).offset(10)
            make.trailing.equalTo(rectangleStars.snp.trailing).offset(-20)
            make.top.equalTo(separator.snp.bottom)
        }
    }

    private enum LayoutMetrics {
        static let nameFontSize: CGFloat = 18
        static let spotFontSize: CGFloat = 14
        static let imagePonintMapFontSize: CGFloat = 12
        static let stackSpotSpace: CGFloat = 4
        static let stackNameProfileSpace: CGFloat = 5
        static let stackProfileSpace: CGFloat = 13
        static let profileImageWidth: CGFloat = 58
        static let profileImageHeight: CGFloat = 58
        static let starFontSize: CGFloat = 24
        static let stackListStars: CGFloat = 36
        static let titleFontSize: CGFloat = 16
        static let stackLabelSpace: CGFloat = 122
        static let rectangleCornerRadius: CGFloat = 8
        static let geralLeading: CGFloat = 15
        static let rectangleHeight1: CGFloat = 100
        static let rectangleTop1: CGFloat = 82
        static let firstStackLeading: CGFloat = 14
    }
}
