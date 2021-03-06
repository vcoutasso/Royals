//
//  SearchResultsViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 06/09/21.
//

import SnapKit
import UIKit

final class SearchResultsViewController: UITableViewController {
    // MARK: - Overridden methods

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Assets.Colors.darkSystemGray5.color
        tableView.backgroundColor = Assets.Colors.darkSystemGray5.color
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchResultsHeaderView()

        tableView.setAndLayoutTableHeaderView(header: header) { make in
            make.top.equalToSuperview()
                .offset(LayoutMetrics.topHeaderOffset)
            make.leading.equalToSuperview()
                .offset(LayoutMetrics.leadingOffset)
        }

        return header
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchResultsCellView(spotName: "Pico Sei lá Meu", address: "Rua das Pitangas, Batel, Curitiba")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let topHeaderOffset: CGFloat = 30
        static let leadingOffset: CGFloat = 20
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}

#if DEBUG
    import SwiftUI
    struct SearchResultsViewControllerPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                return SearchResultsViewController()
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
