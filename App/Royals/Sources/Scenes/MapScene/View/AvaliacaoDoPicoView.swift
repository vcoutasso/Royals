//
//  AvaliacaoDoPicoView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 18/09/21.
//

import UIKit

class AvaliacaoDoPicoView: UIView {
    private var profileImage = UIImageView()
    private var profileName: String
    private var nomeSpot: String

    private var imagePonintMap: UIImageView = {
        UIImageView(image: UIImage(systemName: Strings.Names.Icons.mappinPont)?
            .withTintColor(Assets.Colors.lightGray.color))
    }()

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

        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var firstStack: UIStackView = {
        let name = UILabel()
        name.text = profileName
        name.font = .systemFont(ofSize: LayoutMetrics.nameFontSize, weight: .semibold)
        let spot = UILabel()
        spot.text = nomeSpot
        spot.font = .systemFont(ofSize: LayoutMetrics.spotFontSize, weight: .regular)
        spot.textColor = Assets.Colors.lightGray.color

        let stackSpot = UIStackView(arrangedSubviews: [imagePonintMap, spot])
        stackSpot.axis = .horizontal
        stackSpot.alignment = .leading

        let stackNameProfile = UIStackView(arrangedSubviews: [name, stackSpot])
        stackNameProfile.axis = .vertical
        stackNameProfile.alignment = .leading

        profileImage.contentMode = .scaleAspectFill
        profileImage.makeRoundedProfile()
        profileImage.frame.size = CGSize(width: 58, height: 58)

        let stackGeral = UIStackView(arrangedSubviews: [profileImage, stackNameProfile])
        stackGeral.axis = .horizontal
        stackGeral.alignment = .leading
        stackGeral.backgroundColor = Assets.Colors.darkSystemGray5.color
        stackGeral.layer.cornerRadius = 8

        return stackGeral

    }()

    private func setupHierarchy() {
        addSubview(firstStack)
    }

    private func setupConstraints() {
        firstStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(82)
            make.height.equalTo(100)
        }
    }

    private enum LayoutMetrics {
        static let nameFontSize: CGFloat = 18
        static let spotFontSize: CGFloat = 14
    }
}
