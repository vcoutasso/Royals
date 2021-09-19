//
//  ProfileViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 09/09/21.
//

import FirebaseAuth
import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Public attributes

    var didSendEventClosure: ((ProfileViewController.Event) -> Void)?

    // MARK: - Private attributes

    private lazy var userCard: UserCardView = .init { [weak self] in
        guard let self = self else { return }

        let settingsVC = SettingsViewController()
        // TODO: Push VC instead of presenting it modally
        self.present(settingsVC, animated: true)
    }

    private lazy var highlightsCard: HighlightsCardView = .init()

    private lazy var logoutButton: UIButton = {
        let btn = UIButton()

        btn.setTitle(Strings.Localizable.ProfileScene.LogoutButton.title, for: .normal)
        btn.setTitleColor(Assets.Colors.red.color, for: .normal)
        btn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }

    private func setupHierarchy() {
        view.addSubview(userCard)
        view.addSubview(logoutButton)
        view.addSubview(highlightsCard)
    }

    private func setupConstraints() {
        userCard.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
                .offset(LayoutMetrics.cardVerticalPadding)
            make.width.equalTo(LayoutMetrics.userCardWidth)
            make.height.equalTo(LayoutMetrics.userCardHeight)
            make.centerX.equalToSuperview()
        }

        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        highlightsCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(LayoutMetrics.highlightsCardWidth)
            make.height.equalTo(LayoutMetrics.highlightsCardHeight)
            make.top.equalTo(userCard.snp.bottom)
                .offset(LayoutMetrics.cardVerticalPadding)
        }
    }

    @objc private func logoutButtonTapped() {
        try? Auth.auth().signOut()

        didSendEventClosure?(.logout)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let cardVerticalPadding: CGFloat = 20
        static let userCardWidth: CGFloat = 340
        static let userCardHeight: CGFloat = 180
        static let highlightsCardWidth: CGFloat = userCardWidth
        static let highlightsCardHeight: CGFloat = 145
    }
}

extension ProfileViewController {
    enum Event {
        case logout
    }
}
