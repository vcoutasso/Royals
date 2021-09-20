//
//  ProfileViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 09/09/21.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Public attributes

    var didSendEventClosure: ((ProfileViewController.Event) -> Void)?

    // MARK: - Private attributes

    private lazy var userCard: UserCardView = .init { [weak self] in
        self?.didSendEventClosure?(.settings)
    }

    private lazy var highlightsCard: HighlightsCardView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        didSendEventClosure?(.profile)
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = Assets.Colors.darkSystemGray6.color
    }

    private func setupHierarchy() {
        view.addSubview(userCard)
        view.addSubview(highlightsCard)
    }

    private func setupConstraints() {
        userCard.snp.makeConstraints { make in
            make.topMargin.equalTo(view.layoutMarginsGuide.snp.topMargin)
                .offset(LayoutMetrics.cardVerticalPadding)
            make.width.equalTo(LayoutMetrics.userCardWidth)
            make.height.equalTo(LayoutMetrics.userCardHeight)
            make.centerX.equalToSuperview()
        }

        highlightsCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(LayoutMetrics.highlightsCardWidth)
            make.height.equalTo(LayoutMetrics.highlightsCardHeight)
            make.top.equalTo(userCard.snp.bottom)
                .offset(LayoutMetrics.cardVerticalPadding)
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let cardVerticalPadding: CGFloat = 20
        static let userCardWidth: CGFloat = 340
        static let userCardHeight: CGFloat = 180
        static let highlightsCardWidth: CGFloat = userCardWidth
        static let highlightsCardHeight: CGFloat = 145
    }
}

extension ProfileViewController {
    enum Event {
        case profile
        case settings
        case logout
    }
}

#if DEBUG
    import SwiftUI
    struct ProfilePreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                return ProfileViewController()
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
