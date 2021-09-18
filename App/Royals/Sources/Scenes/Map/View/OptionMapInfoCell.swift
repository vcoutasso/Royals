//
//  OptionMapInfoCell.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 13/09/21.
//

import UIKit

final class OptionMapInfoCell: UITableViewCell {
    // MARK: - Public attributes

    private var button = UIButton()

    private var icon = UIImageView()

    private var type: MapPinType?

    static let cellId = "OptionCell"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(button)
        addSubview(icon)
        configure()
        setupConstraints()
        backgroundColor = Assets.Colors.darkSystemGray5.color
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Publich methods

    func set(option: Option) {
        button.setTitle(option.nameButton, for: .normal)
        icon.image = option.icon
        type = option.type

        switch type {
        case .skateSpot:
            button.setTitleColor(Assets.Colors.green.color, for: .normal)
            icon.tintColor = Assets.Colors.green.color
        case .skateStopper:
            button.setTitleColor(Assets.Colors.red.color, for: .normal)
            icon.tintColor = Assets.Colors.red.color
        default: break
        }
    }

    func configure() {
        button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutMetrics.buttonFontSize, weight: .semibold)
        button.contentHorizontalAlignment = .leading

        icon.contentMode = .scaleAspectFit
    }

    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(icon).offset(-15)
        }

        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.trailing.equalToSuperview().offset(-15)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let buttonFontSize: CGFloat = 14
        static let imageToTextDistance: CGFloat = 44
    }
}
