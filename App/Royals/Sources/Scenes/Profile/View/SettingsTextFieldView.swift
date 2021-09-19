//
//  SettingsTextFieldView.swift
//  Royals
//
//  Created by Vinícius Couto on 18/09/21.
//

import UIKit

final class SettingsTextFieldView: UIStackView {
    // MARK: - Private attributes

    private weak var delegate: UITextFieldDelegate?
    private var textFieldTitle: String
    private var placeholderText: String

    // MARK: - Initialization

    init(delegate: UITextFieldDelegate, textFieldTitle: String, placeholderText: String) {
        self.delegate = delegate
        self.textFieldTitle = textFieldTitle
        self.placeholderText = placeholderText

        super.init(frame: .zero)

        setupStackView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupStackView() {
        let title = UILabel()
        title.text = textFieldTitle
        title.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .regular)
        title.textColor = Assets.Colors.white.color

        let textField = UITextField()
        textField.placeholder = placeholderText
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: LayoutMetrics.leftViewWidth,
                                                  height: textField.frame.size.height))
        textField.leftViewMode = .always
        textField.backgroundColor = Assets.Colors.darkSystemGray5.color
        textField.layer.cornerRadius = LayoutMetrics.cornerRadius
        textField.delegate = delegate

        addArrangedSubview(title)
        addArrangedSubview(textField)

        axis = .vertical
        alignment = .leading
        spacing = LayoutMetrics.verticalSpacing

        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(LayoutMetrics.height)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let titleFontSize: CGFloat = 18
        static let height: CGFloat = 40
        static let leftViewWidth: CGFloat = 10
        static let cornerRadius: CGFloat = 8
        static let verticalSpacing: CGFloat = 5
    }
}
