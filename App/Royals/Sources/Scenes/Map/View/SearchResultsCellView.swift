//
//  SearchResultsCellView.swift
//  Royals
//
//  Created by Vinícius Couto on 06/09/21.
//

import UIKit

final class SearchResultsCellView: UITableViewCell {
    // MARK: - Public attributes

    var spotName: String?
    var address: String?

    private var title: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: LayoutMetrics.spotNameFontSize, weight: .bold)
        label.textColor = Assets.Colors.white.color
        label.text = spotName

        return label
    }

    private var subtitle: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: LayoutMetrics.spotAddressFontSize, weight: .light)
        label.textColor = Assets.Colors.lightGray.color
        label.text = address

        return label
    }

    private var info: UIStackView {
        let vstack = UIStackView(arrangedSubviews: [title, subtitle])
        vstack.axis = .vertical
        vstack.alignment = .leading

        return vstack
    }

    // MARK: - Initialization

    convenience init(spotName: String, address: String) {
        self.init(style: .default, reuseIdentifier: nil)

        self.spotName = spotName
        self.address = address

        imageView?.image = Assets.Images.miniSkateSpot.image
        imageView?.contentMode = .scaleAspectFit

        setupView()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = Assets.Colors.darkSystemGray5.color

        let cellView = UIStackView(arrangedSubviews: [imageView ?? UIImageView(), info])
        cellView.axis = .horizontal
        cellView.alignment = .leading
        cellView.spacing = LayoutMetrics.imageToTextDistance

        contentView.addSubview(cellView)

        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let spotNameFontSize: CGFloat = 16
        static let spotAddressFontSize: CGFloat = 12
        static let imageToTextDistance: CGFloat = 30
    }
}
