//
//  SearchBarView.swift
//  Skatable
//
//  Created by Vinícius Couto on 02/09/21.
//

import UIKit

final class SearchBarView: UISearchBar, UISearchBarDelegate {
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        searchBarStyle = .prominent
        placeholder = Strings.Localizable.MapView.whereTo
        backgroundImage = UIImage()
        isTranslucent = true
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
}
