//
//  WIPViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 03/09/21.
//

import UIKit

class WIPViewController: UIViewController {
    // MARK: - Private variables

    private lazy var imageView: UIImageView = .init()

    // MARK: - Overridden methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViews() {
        imageView.image = UIImage(asset: Assets.Images.wip)
    }

    private func setupHierarchy() {
        view.addSubview(imageView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalToSuperview()
        }
    }
}
