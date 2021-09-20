//
//  SpotEvaluationViewController.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 18/09/21.
//

import UIKit

class SpotEvaluationViewController: UIViewController {
    private lazy var profile: SpotEvaluationView =
        .init(profileImage: UIImageView(image: Assets.Images.profileImage.image),
              profileName: "Malu", nomeSpot: "Pico Sei lá Meu")

    private lazy var commentProfile1: CardComments =
        .init(profileImage: UIImageView(image: Assets.Images.profileImage2.image),
              profileName: "Puppy", nomeSpot: "Pico Sei lá Meu",
              ratingStars: 4,
              commentText: "Pico maneiro, true demais.", data: "Há 3 dias")

    private lazy var commentProfile2: CardComments =
        .init(profileImage: UIImageView(image: Assets.Images.profileImage3.image),
              profileName: "Erick", nomeSpot: "Pico Sei lá Meu",
              ratingStars: 4,
              commentText: "Pico maneiro, deu até pra tirar um ronco.", data: "Há 5 dias")

    private var scrollView = UIScrollView()
    let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.frame = view.bounds
        setupHierarchy()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.addSubview(scrollView)
        contentView.addSubview(profile)
        contentView.addSubview(commentProfile1)
        contentView.addSubview(commentProfile2)
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.bounds.size
        // scrollView.contentSize = contentView.bounds.size
    }

    private func setupConstraints() {
        profile.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(430)
        }

        commentProfile1.snp.makeConstraints { make in
            make.top.equalTo(profile.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        commentProfile2.snp.makeConstraints { make in
            make.top.equalTo(commentProfile1.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        contentView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(commentProfile2.snp.bottom)
        }

        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }
}
