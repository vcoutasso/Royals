//
//  FeedViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 19/09/21.
//

import UIKit

class FeedViewController: UIViewController {
    // MARK: - Private attributes

    private lazy var searchBar: SearchBarView = {
        .init(placeholder: Strings.Localizable.FeedScene.SearchBar.placeholder)
    }()

    // MARK: - View controller lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViews() {
        view.backgroundColor = Assets.Colors.darkSystemGray5.color
    }

    private func setupHierarchy() {
        view.addSubview(searchBar)
    }

    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutMetrics.searchBarBottomOffset)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.searchBarHorizontalPadding)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let searchBarBottomOffset: CGFloat = 5
        static let searchBarHorizontalPadding: CGFloat = 18
    }
}
