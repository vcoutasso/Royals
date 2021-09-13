//
//  ProfileViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 09/09/21.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Private attributes

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
        view.addSubview(logoutButton)
    }

    private func setupConstraints() {
        logoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func logoutButtonTapped() {
        resetUserCredentials()
    }
}
