//
//  SeparatorView.swift
//  Skatable
//
//  Created by Maria Luiza Amaral on 14/09/21.
//

import UIKit

class SeparatorView: UIView {
    init() {
        super.init(frame: .zero)
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = Assets.Colors.darkSystemGray1.color
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0.5)
    }
}
