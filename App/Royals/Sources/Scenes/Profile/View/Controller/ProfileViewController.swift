//
//  ProfileViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 09/09/21.
//

import FirebaseAuth
import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Public attributes

    var didSendEventClosure: ((ProfileViewController.Event) -> Void)?

    // MARK: - Private attributes

    private lazy var userCard: UserCardView = .init()

    private lazy var logoutButton: UIButton = {
        let btn = UIButton()

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Strings.Localizable.ProfileScene.LogoutButton.title, for: .normal)
        btn.setTitleColor(Assets.Colors.red.color, for: .normal)
        btn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.addSubview(userCard)
        view.addSubview(logoutButton)
    }

    private func setupConstraints() {
        userCard.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
                .offset(20)
            make.height.equalTo(LayoutMetrics.userCardHeight)
            make.width.equalTo(LayoutMetrics.userCardWidth)
            make.centerX.equalToSuperview()
        }

        logoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func logoutButtonTapped() {
        try? Auth.auth().signOut()

        didSendEventClosure?(.logout)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let userCardWidth: CGFloat = 340
        static let userCardHeight: CGFloat = 180
    }
}

extension ProfileViewController {
    enum Event {
        case logout
    }
}
