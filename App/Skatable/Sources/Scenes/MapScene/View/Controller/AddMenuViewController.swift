//
//  AddMenuViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 02/09/21.
//

import UIKit

final class AddMenuViewController: UIViewController {
    // MARK: - Private variables

    private var spotButtonAction: (() -> Void)?
    private var stopperButtonAction: (() -> Void)?

    private lazy var skateSpotButton: AddOptionView = .init(iconName: Strings.Names.Icons.skateSpot,
                                                            type: .skateSpot,
                                                            action: {})
    private lazy var skateStopperButton: AddOptionView = .init(iconName: Strings.Names.Icons.skateStopper,
                                                               type: .skateStopper,
                                                               action: {})

    private lazy var optionsStack: UIStackView = .init(arrangedSubviews: [
        skateSpotButton,
        skateStopperButton,
    ])

    // MARK: - Public methods

    func addButtonTargets(spotButtonAction: @escaping (() -> Void), stopperButtonAction: @escaping (() -> Void)) {
        self.spotButtonAction = spotButtonAction
        self.stopperButtonAction = stopperButtonAction
    }

    // MARK: - Overridden methods

    override func viewDidLoad() {
        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViews() {
        optionsStack.axis = .vertical
        optionsStack.alignment = .center
        optionsStack.distribution = .equalCentering
        optionsStack.spacing = LayoutMetrics.menuOptionsSpacing
    }

    private func setupHierarchy() {
        view.addSubview(optionsStack)
    }

    private func setupConstraints() {
        optionsStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func skateSpotButtonTap() {
        guard let action = spotButtonAction else { return }

        action()
    }

    @objc private func skateStopperButtonTap() {
        guard let action = stopperButtonAction else { return }

        action()
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let menuOptionsSpacing: CGFloat = 10
    }
}
