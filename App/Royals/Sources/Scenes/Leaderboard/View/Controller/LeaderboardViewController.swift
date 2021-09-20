//
//  LeaderboardViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 20/09/21.
//

import UIKit

// FIXME: This should not be just an image with a searchbar
class LeaderboardViewController: UIViewController {
    // MARK: - Private variables

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: Assets.Images.leaderboard)
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var searchBar: SearchBarView = .init(placeholder: Strings.Localizable
        .LeaderboardScene.SearchBar.placeholder)

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, searchBar])
        stack.axis = .vertical
        stack.alignment = .fill

        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.searchBarHorizontalPadding)
        }

        return stack
    }()

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViews() {
        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }

    private func setupHierarchy() {
        view.addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

    // MARK: Layout Metrics

    private enum LayoutMetrics {
        static let searchBarHorizontalPadding: CGFloat = 18
    }
}
