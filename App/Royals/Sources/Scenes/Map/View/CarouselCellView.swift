//
//  CarouselCellView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 09/09/21.
//

import UIKit
class CarouselCellView: UICollectionViewCell {
    // MARK: - SubViews

    private lazy var imageView = UIImageView()

    // MARK: - Properties

    static let cellId = "CarouselCell"

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setups

private extension CarouselCellView {
    func setupUI() {
        backgroundColor = .clear

        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Public

extension CarouselCellView {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}
