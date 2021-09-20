//
//  StarFillView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 19/09/21.
//

import UIKit

final class StarFillView: UIImageView {
    private let color = UIColor()
    init(colorTint: UIColor, size: CGFloat) {
        super.init(frame: CGRect.zero)
        makeStarFill(color: colorTint, size: size)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeStarFill(color: UIColor, size: CGFloat) {
        let font = UIFont.systemFont(ofSize: size, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font)

        image = UIImage(systemName: Strings.Names.Icons.star, withConfiguration: configuration)
        tintColor = color
        contentMode = .scaleAspectFit

        if size == 24 {
            snp.makeConstraints { make in
                make.width.equalTo(31)
                make.height.equalTo(22)
            }
        } else {
            snp.makeConstraints { make in
                make.width.equalTo(18)
                make.height.equalTo(22)
            }
        }
    }
}
