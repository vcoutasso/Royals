//
//  SettingToggleView.swift
//  Royals
//
//  Created by Vinícius Couto on 18/09/21.
//

import UIKit

final class SettingToggleView: UIStackView {
    // MARK: - Private attributes

    private var settingTitle: String

    // MARK: - Initialization

    init(title: String) {
        self.settingTitle = title
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        let title = UILabel()
        title.text = settingTitle
        title.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .regular)

        let slider = UISwitch()
        slider.onTintColor = Assets.Colors.yellow.color

        addArrangedSubview(title)
        addArrangedSubview(slider)

        axis = .horizontal
        alignment = .center
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let titleFontSize: CGFloat = 18
    }
}
