//
//  CommentTextFieldView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 19/09/21.
//

import UIKit

class CommentTextFieldView: UITextView {
    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        setupView()
        setupConstrains()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // init

    // setupViews
    private func setupView() {
        backgroundColor = Assets.Colors.darkSystemGray5.color
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = LayoutMetrics.generalCornerRadius
        font = UIFont.systemFont(ofSize: 15)
        isEditable = true
        textColor = Assets.Colors.darkSystemGray2.color
        insertText(Strings.Localizable.MapScene.AvaliacaoDoPico.placeholderComment)
    }

    // setupConstrains
    private func setupConstrains() {
        snp.makeConstraints { make in
            make.height.equalTo(112)
        }
    }

    // LayoutMetrics
    private enum LayoutMetrics {
        static let textFontSize: CGFloat = 25
        static let labelsFont = UIFont.systemFont(ofSize: 16)

        static let generalCornerRadius: CGFloat = 8

        static let generalTopPadding: CGFloat = 20
        static let generalHorizontalPadding: CGFloat = 15

        static let generalItemsSpacing: CGFloat = 42

        static let iconsFontSize: CGFloat = 12
    }
}
