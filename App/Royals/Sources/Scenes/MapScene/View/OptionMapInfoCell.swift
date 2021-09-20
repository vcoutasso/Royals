//
//  OptionMapInfoCell.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 13/09/21.
//

import UIKit

final class OptionMapInfoCell: UITableViewCell {
    // MARK: - Public attributes

    // TODO: fazer as funcoes de cada botao
    var button = UIButton()

    private var icon = UIImageView()

    private var type: MapPinType?

    var action: ((UIButton) -> Void)!

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
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
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

    @objc private func buttonTapped(sender: UIButton) {
        action(sender)
    }

    func configure() {
        button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutMetrics.buttonFontSize, weight: .semibold)
        button.contentHorizontalAlignment = .leading

        icon.contentMode = .scaleAspectFit
    }

    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutMetrics.top)
            make.bottom.equalToSuperview().offset(LayoutMetrics.bottom)
            make.leading.equalToSuperview().offset(LayoutMetrics.leading)
            make.trailing.equalTo(icon).offset(LayoutMetrics.trailing)
        }

        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LayoutMetrics.top)
            make.bottom.equalToSuperview().offset(LayoutMetrics.bottom)
            make.width.equalTo(LayoutMetrics.widthIcon)
            make.trailing.equalToSuperview().offset(LayoutMetrics.trailing)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let buttonFontSize: CGFloat = 14
        static let imageToTextDistance: CGFloat = 44
        static let top: CGFloat = 5
        static let bottom: CGFloat = -5
        static let leading: CGFloat = 15
        static let trailing: CGFloat = -15
        static let widthIcon: CGFloat = 30
    }
}
