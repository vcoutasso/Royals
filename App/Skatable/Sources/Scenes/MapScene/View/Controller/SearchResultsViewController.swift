//
//  SearchResultsViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 06/09/21.
//

import SnapKit
import UIKit

class SearchResultsViewController: UITableViewController {
    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.setAndLayoutTableHeaderView(header: SearchResultsHeaderView()) { make in
            make.top.equalToSuperview()
                .offset(LayoutMetrics.topHeaderOffset)
            make.leading.equalToSuperview()
                .offset(LayoutMetrics.leadingOffset)
        }
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
