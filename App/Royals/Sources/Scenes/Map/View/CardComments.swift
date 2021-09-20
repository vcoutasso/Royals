//
//  CardComments.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 19/09/21.
//

import UIKit

class CardComments: UIView {
    private var profileImage = UIImageView()
    private var profileName: String
    private var nomeSpot: String
    private var ratingStars: Int
    private var commentText: String
    private var data: String

    private var imagePonintMap = UIImageView()
    private let commentLabel = UILabel()
    private let dataLabel = UILabel()
    // TODO: a data tem q ser de outro formato e ainda verificar como vai ser mostrado na view

    init(profileImage: UIImageView, profileName: String, nomeSpot: String, ratingStars: Int, commentText: String,
         data: String) {
        self.profileImage = profileImage
        self.profileName = profileName
        self.nomeSpot = nomeSpot
        self.ratingStars = ratingStars
        self.commentText = commentText
        self.data = data

        super.init(frame: .zero)

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: refazer essa parte do código pra ficar melhor
    private lazy var firstStack: UIStackView = {
        let name = UILabel()
        name.text = profileName
        name.font = .systemFont(ofSize: LayoutMetrics.nameFontSize, weight: .semibold)

        let spot = UILabel()
        spot.text = nomeSpot
        spot.font = .systemFont(ofSize: LayoutMetrics.spotFontSize, weight: .regular)
        spot.textColor = Assets.Colors.lightGray.color

        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)

        imagePonintMap.image = UIImage(systemName: Strings.Names.Icons.mappinPont, withConfiguration: configuration)
        imagePonintMap.tintColor = Assets.Colors.lightGray.color
        imagePonintMap.contentMode = .scaleAspectFit

        let stackSpot = UIStackView(arrangedSubviews: [imagePonintMap, spot])
        stackSpot.axis = .horizontal
        stackSpot.alignment = .leading
        stackSpot.spacing = 4

        let stackNameProfile = UIStackView(arrangedSubviews: [name, stackSpot])
        stackNameProfile.axis = .vertical
        stackNameProfile.alignment = .leading
        stackNameProfile.spacing = 5

        profileImage.contentMode = .scaleAspectFill
        profileImage.frame.size = CGSize(width: 58, height: 58)
        profileImage.makeRoundedProfile()

        let stackProfile = UIStackView(arrangedSubviews: [profileImage, stackNameProfile])
        stackProfile.axis = .horizontal
        stackProfile.alignment = .center
        stackProfile.spacing = 13

        profileImage.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(58)
        }

        let star1: StarFillView = .init(colorTint: .white, size: 14)
        let star2: StarFillView = .init(colorTint: .white, size: 14)
        let star3: StarFillView = .init(colorTint: .white, size: 14)
        let star4: StarFillView = .init(colorTint: .white, size: 14)
        let star5: StarOutlineView = .init(colorTint: .white, size: 14)

        let stackListStars = UIStackView(arrangedSubviews: [star1, star2, star3, star4, star5])
        stackListStars.axis = .horizontal
        stackListStars.alignment = .leading
        stackListStars.spacing = 3

        let stackProfileStars = UIStackView(arrangedSubviews: [stackProfile, stackListStars])
        stackProfileStars.axis = .horizontal
        stackProfileStars.alignment = .leading
        stackProfileStars.spacing = 5

        return stackProfileStars

    }()

    private func setupView() {
        backgroundColor = Assets.Colors.darkSystemGray5.color
        layer.cornerRadius = 8

        commentLabel.text = commentText
        commentLabel.font = .systemFont(ofSize: 16, weight: .regular)

        dataLabel.text = data
        dataLabel.textColor = Assets.Colors.darkSystemGray2.color
        dataLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }

    private func setupHierarchy() {
        addSubview(firstStack)
        addSubview(commentLabel)
        addSubview(dataLabel)
    }

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(154)
        }

        firstStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalToSuperview().offset(16)
        }

        commentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(firstStack.snp.bottom).offset(18)
        }

        dataLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(269)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(commentLabel.snp.bottom).offset(14)
        }
    }

    private enum LayoutMetrics {
        static let nameFontSize: CGFloat = 24
        static let spotFontSize: CGFloat = 14
    }
}
