//
//  SearchBarView.swift
//  Royals
//
//  Created by Vinícius Couto on 02/09/21.
//

import UIKit

final class SearchBarView: UISearchBar {
    // MARK: - Initialization

    init(placeholder: String?) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        searchTextField.backgroundColor = Assets.Colors.darkSystemGray5.color
        searchTextField.textColor = Assets.Colors.darkSystemGray1.color
        searchTextField.leftView?.tintColor = Assets.Colors.darkSystemGray1.color

        searchBarStyle = .minimal
        barTintColor = Assets.Colors.darkSystemGray1.color

        delegate = self
    }
}

extension SearchBarView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
