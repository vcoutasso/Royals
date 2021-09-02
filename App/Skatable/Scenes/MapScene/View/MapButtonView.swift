//
//  MapButtonView.swift
//  Skatable
//
//  Created by Bruno Thuma on 02/09/21.
//

import UIKit

class MapButtonView: UIButton {
    private var icon: UIImage
    private var action: () -> Void

    init(iconName: String, action: @escaping (() -> Void)) {
        icon = UIImage(systemName: iconName)!

        self.action = action

        super.init(frame: .zero)

        // TODO: implement our own color pallete here
        backgroundColor = .systemGray
        setImage(icon, for: .normal)

        target(forAction: #selector(tap), withSender: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tap() {
        action()
    }
}
