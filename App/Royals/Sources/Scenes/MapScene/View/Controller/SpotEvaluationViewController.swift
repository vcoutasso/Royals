//
//  SpotEvaluationViewController.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 18/09/21.
//

import UIKit

class SpotEvaluationViewController: UIViewController {
    private lazy var profile: AvaliacaoDoPicoView =
        .init(profileImage: UIImageView(image: Assets.Images.profileImage.image),
              profileName: "Malu", nomeSpot: "Pico Sei lá Meu")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.addSubview(profile)
    }

    private func setupConstraints() {
        profile.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }
}
