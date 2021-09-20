//
//  PostStackView.swift
//  Royals
//
//  Created by Vinícius Couto on 19/09/21.
//

import UIKit

final class PostStackView: UIStackView {
    // MARK: - Private attributes

    private lazy var image: UIImageView = {
        let imageView = UIImageView(image: UIImage(asset: Assets.Images.dummyPostPic1))
        imageView.sizeToFit()

//        let width: CGFloat = 300
//        let height: CGFloat = imageView.image!.size.height
//
//        let mask = CALayer()
//        mask.contents
//        mask.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
//
//        imageView.layer.mask = mask
//        imageView.layer.masksToBounds = true

        return imageView
    }()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setupViews()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupViews() {
        let header: PostHeaderView = .init(originalPoster: .init(),
                                           spotName: "carai mermao",
                                           postTitle: "olha que doido")

        axis = .vertical
        alignment = .center
        spacing = 10

        addArrangedSubview(header)
        addArrangedSubview(image)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {}
}
