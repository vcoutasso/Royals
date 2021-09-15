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

    private var option = UIStackView()

    static let cellId = "OptionCell"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(option)
        configure()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Publich methods

    func set(option: Option) {
        button.setTitle(option.nameButton, for: .normal)
        icon.image = option.icon
    }

    func configure() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutMetrics.buttonFontSize, weight: .semibold)
        button.setTitleColor(Assets.Colors.green.color, for: .normal)

        icon.translatesAutoresizingMaskIntoConstraints = false

        option = UIStackView(arrangedSubviews: [button, icon])

        option.axis = .horizontal
        option.alignment = .leading
        option.distribution = .fill
    }

    private func setupConstraints() {
        option.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(509)
//            make.leading.equalToSuperview().offset(15)
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let buttonFontSize: CGFloat = 14
        static let imageToTextDistance: CGFloat = 44
    }
}
