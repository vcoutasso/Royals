//
//  SearchBarView.swift
//  Skatable
//
//  Created by Vinícius Couto on 02/09/21.
//

import UIKit

final class SearchBarView: UIView, UISearchBarDelegate {
    // MARK: - Private variables

    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()

        bar.searchBarStyle = .default
        bar.placeholder = Strings.Localizable.MapView.whereTo
        bar.backgroundImage = UIImage()
        bar.isTranslucent = true
        bar.delegate = self
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        addSubview(searchBar)
    }

    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
