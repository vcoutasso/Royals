//
//  PostSubtitleView.swift
//  Royals
//
//  Created by Vinícius Couto on 19/09/21.
//

import UIKit

class PostSubtitleView: UILabel {
    // MARK: - Private methods

    private let separator: String = " • "
    private let emptySpace: String = " "

    private var userHandle: String
    private var username: String
    private var spotName: String

    private lazy var handleString: NSAttributedString = {
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: LayoutMetrics.subtitleFontSize, weight: .bold),
            NSAttributedString.Key.foregroundColor: Assets.Colors.lightGray.color,
        ]

        return NSAttributedString(string: userHandle + emptySpace, attributes: attributes)
    }()

    private lazy var usernameString: NSAttributedString = {
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: LayoutMetrics.subtitleFontSize, weight: .light),
            NSAttributedString.Key.foregroundColor: Assets.Colors.lightGray.color,
        ]

        return NSAttributedString(string: username + separator, attributes: attributes)
    }()

    private lazy var spotString: NSAttributedString = {
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: LayoutMetrics.subtitleFontSize, weight: .bold),
            NSAttributedString.Key.foregroundColor: Assets.Colors.yellow.color,
        ]

        return NSAttributedString(string: spotName, attributes: attributes)
    }()

    init(handle: String, username: String, spotName: String) {
        self.userHandle = handle
        self.username = username
        self.spotName = spotName

        super.init(frame: .zero)

        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupViews() {
        let attributedString = NSMutableAttributedString()
        attributedString.append(handleString)
        attributedString.append(usernameString)
        attributedString.append(spotString)

        attributedText = attributedString
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let subtitleFontSize: CGFloat = 12
    }
}
