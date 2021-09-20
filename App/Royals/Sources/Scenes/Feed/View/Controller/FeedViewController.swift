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

    private lazy var dummyPost1: PostStackView = {
        .init()
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
        view.addSubview(dummyPost1)
    }

    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutMetrics.searchBarBottomOffset)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.searchBarHorizontalPadding)
        }

        dummyPost1.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
                .offset(20)
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
