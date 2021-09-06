//
//  SearchResultsCellView.swift
//  Skatable
//
//  Created by Vinícius Couto on 06/09/21.
//

import UIKit

class SearchResultsCellView: UITableViewCell {
    // MARK: - Public attributes

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

    var spotName: String?
    var address: String?

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        imageView?.image = Assets.Images.miniSkateSpot.image
        imageView?.contentMode = .scaleAspectFit
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Publich methods

    func configure(spotName: String, address: String) {
        self.spotName = spotName
        self.address = address

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
