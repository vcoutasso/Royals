//
//  SearchResultsViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 06/09/21.
//

import SnapKit
import UIKit

class SearchResultsViewController: UITableViewController {
    // MARK: - Private attributes

    private lazy var tableHeader: UIStackView = {
        // Label
        let viewTitleLabel = UILabel()
        viewTitleLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: LayoutMetrics.viewTitleFontSize)
        viewTitleLabel.text = Strings.Localizable.MapScene.SearchResults.title

        // Current location item
        let locationMarker = UIImageView(image: UIImage(asset: Assets.Images.userLocationMarker))
        locationMarker.contentMode = .scaleAspectFit
        let subtitleText = UILabel()
        subtitleText.text = Strings.Localizable.MapScene.SearchResults.subtitle
        subtitleText.font = UIFont.systemFont(ofSize: LayoutMetrics.itemTitleFontSize, weight: .bold)
        subtitleText.textColor = Assets.Colors.yellow.color
        subtitleText.textAlignment = .center

        // Hstack
        let subtitleItem = UIStackView(arrangedSubviews: [locationMarker, subtitleText])
        subtitleItem.axis = .horizontal
        subtitleItem.alignment = .leading
        subtitleItem.spacing = LayoutMetrics.itemImageToTextDistance

        // Align text to center of the image
        subtitleText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
                .offset(-subtitleText.font.pointSize / 2)
        }

        let header = UIStackView(arrangedSubviews: [viewTitleLabel, subtitleItem])
        header.axis = .vertical
        header.alignment = .leading
        header.spacing = 20
        header.translatesAutoresizingMaskIntoConstraints = true

        return header
    }()

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.setAndLayoutTableHeaderView(header: tableHeader) { make in
            make.top.equalToSuperview()
                .offset(LayoutMetrics.topHeaderOffset)
            make.leading.equalToSuperview()
                .offset(LayoutMetrics.leadingOffset)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let viewTitleFontSize: CGFloat = 22
        static let topHeaderOffset: CGFloat = 30
        static let leadingOffset: CGFloat = 20
        static let itemTitleFontSize: CGFloat = 16
        static let itemHorizontalPadding: CGFloat = 30
        static let itemHeight: CGFloat = 40
        static let itemVerticalPadding: CGFloat = 15
        static let itemImageToTextDistance: CGFloat = 30
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
