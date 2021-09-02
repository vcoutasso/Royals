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
        placeholder = Strings.Localizable.MapView.whereTo

        searchTextField.backgroundColor = Assets.Colors.darkSystemGray5.color
        searchTextField.textColor = Assets.Colors.darkSystemGray1.color
        searchTextField.leftView?.tintColor = Assets.Colors.darkSystemGray1.color

        searchBarStyle = .minimal
        tintColor = Assets.Colors.darkSystemGray1.color
        barTintColor = Assets.Colors.darkSystemGray1.color

        delegate = self

        translatesAutoresizingMaskIntoConstraints = false
    }
}
