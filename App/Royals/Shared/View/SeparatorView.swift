//
//  SeparatorView.swift
//  Royals
//
//  Created by Maria Luiza Amaral on 14/09/21.
//

import SnapKit
import UIKit

final class SeparatorView: UIView {
    // MARK: - Private attributes

    private var constraintMaker: ((ConstraintMaker) -> Void)?
    private var sizeSeparatorMaker: ((ConstraintMaker) -> Void)?

    // MARK: - Initialization

    @available(*, unavailable)
    init() {
        fatalError("This class should not be instantiated directly. Use factory methods instead.")
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func didMoveToSuperview() {
        if let maker = constraintMaker {
            snp.makeConstraints(maker)
        }

        // If sizeSeparatorMaker is nil, something is broken with the interface to this class
        snp.makeConstraints(sizeSeparatorMaker!)
    }

    // MARK: - Static constructors

    static func createVerticalFieldSeparator(_ constraints: @escaping (ConstraintMaker) -> Void) -> SeparatorView {
        let separator = SeparatorView(frame: .zero)
        separator.constraintMaker = constraints
        separator.sizeSeparatorMaker = { make in
            make.width.equalTo(LayoutMetrics.verticalFieldSeparatorWidth)
        }
        separator.backgroundColor = Assets.Colors.darkSystemGray2.color

        return separator
    }

    static func createHorizontalFieldSeparator(_ constraints: @escaping (ConstraintMaker) -> Void) -> SeparatorView {
        let separator = SeparatorView(frame: .zero)
        separator.constraintMaker = constraints
        separator.sizeSeparatorMaker = { make in
            make.height.equalTo(LayoutMetrics.horizontalFieldSeparatorWidth)
        }
        separator.backgroundColor = Assets.Colors.darkSystemGray1.color

        return separator
    }

    static func createHorizontalListSeparator(_ constraints: @escaping (ConstraintMaker) -> Void) -> SeparatorView {
        let separator = SeparatorView(frame: .zero)
        separator.constraintMaker = constraints
        separator.sizeSeparatorMaker = { make in
            make.height.equalTo(LayoutMetrics.horizontalListSeparatorWidth)
        }
        separator.backgroundColor = Assets.Colors.separatorGray.color

        return separator
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let verticalFieldSeparatorWidth: CGFloat = 2
        static let horizontalFieldSeparatorWidth: CGFloat = 0.5
        static let horizontalListSeparatorWidth: CGFloat = 0.3
    }
}
