//
//  UserCardView.swift
//  Royals
//
//  Created by Vinícius Couto on 14/09/21.
//

import UIKit

class UserCardView: UIView {
    // MARK: - Private attributes

    // TODO: Add button tapped target
    private lazy var settingsButton: UIButton = {
        let font = UIFont.systemFont(ofSize: LayoutMetrics.buttonIconFontSize, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)

        let icon = UIImage(systemName: Strings.Names.Icons.settings, withConfiguration: configuration)

        let normalIcon = icon?.imageWithColor(color: Assets.Colors.black.color)
        let highlightedIcon = icon?.imageWithColor(color: Assets.Colors.darkSystemGray3.color)

        let backgroundImage = UIImage(systemName: Strings.Names.Icons.squareFill)

        let button = UIButton()
        // FIXME: Background image does not seem to fill the frame rect
        button.setBackgroundImage(backgroundImage, for: .normal)
        button.setImage(normalIcon, for: .normal)

        return button
    }()

    private lazy var profilePicture: UIImageView = {
        let image = UIImageView(image: Assets.Images.dummyUserImage.image)
        image.makeRounded()

        return image
    }()

    private lazy var userInfo: UIStackView = {
        let userHandle = UILabel()
        userHandle.text = CurrentUser.shared.user?.handle
        userHandle.font = UIFont.systemFont(ofSize: LayoutMetrics.userHandleFontSize, weight: .semibold)
        userHandle.textColor = Assets.Colors.lightGray.color

        let username = UILabel()
        username.text = CurrentUser.shared.user?.username
        username.font = UIFont.systemFont(ofSize: LayoutMetrics.usernameFontSize, weight: .light)
        username.textColor = Assets.Colors.lightGray.color

        let stack = UIStackView(arrangedSubviews: [userHandle, username])
        stack.axis = .vertical
        stack.alignment = .center

        return stack
    }()

    // Thanks https://stackoverflow.com/a/44099613
    private lazy var userStats: UIStackView = {
        let stack = UIStackView()
        let items = ["4 publicações", "1.8k ossos quebrados", "500 manobras"]

        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = LayoutMetrics.statsStackSpacing

        for item in items {
            if !stack.arrangedSubviews.isEmpty {
                let separator = UIView()
                separator.backgroundColor = Assets.Colors.darkGray.color
                stack.addArrangedSubview(separator)

                separator.snp.makeConstraints { make in
                    make.width.equalTo(LayoutMetrics.statsStackSeparatorWidth)
                    make.height.equalTo(stack.snp.height)
                        .multipliedBy(LayoutMetrics.statsStackHeightMultiplier)
                }
            }

            let label = UILabel()
            label.text = item
            label.font = UIFont.systemFont(ofSize: LayoutMetrics.userStatsFontSize, weight: .light)
            label.textColor = Assets.Colors.lightGray.color
            stack.addArrangedSubview(label)
        }

        return stack
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
        addSubview(settingsButton)
        addSubview(profilePicture)
        addSubview(userInfo)
        addSubview(userStats)
    }

    private func setupConstraints() {
        settingsButton.snp.makeConstraints { make in
            make.size.equalTo(LayoutMetrics.buttonBackgroundRectSize)
            make.topMargin.equalTo(snp.topMargin)
                .offset(LayoutMetrics.settingsButtonOffset)
            make.rightMargin.equalTo(snp.rightMargin)
                .offset(-LayoutMetrics.settingsButtonOffset)
        }

        profilePicture.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(settingsButton.snp.centerY)
        }

        userInfo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(profilePicture.snp.bottomMargin)
                .offset(LayoutMetrics.userInfoVerticalPadding)
        }

        userStats.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(userInfo.snp.bottomMargin)
            make.bottomMargin.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        private static let rectSize: CGFloat = 32

        static let buttonBackgroundRectSize = CGSize(width: rectSize, height: rectSize)
        static let buttonIconFontSize: CGFloat = 16
        static let cornerRadius: CGFloat = 8
        static let profilePictureRadius: CGFloat = 31
        static let settingsButtonOffset: CGFloat = 7
        static let settingsButtonCornerRadius: CGFloat = 6
        static let userHandleFontSize: CGFloat = 22
        static let usernameFontSize: CGFloat = 18
        static let userStatsFontSize: CGFloat = 12
        static let statsStackSeparatorWidth: CGFloat = 2
        static let statsStackHeightMultiplier: CGFloat = 0.4
        static let statsStackSpacing: CGFloat = 5
        static let userInfoVerticalPadding: CGFloat = 10
    }
}
