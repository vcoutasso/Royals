//
//  PostHeaderView.swift
//  Royals
//
//  Created by Vinícius Couto on 19/09/21.
//

import UIKit

class PostHeaderView: UIView {
    // MARK: - Private variables

    private var originalPoster: AppUser
    private var spotName: String

    private lazy var subtitleView: PostSubtitleView = {
        .init(handle: originalPoster.handle,
              username: originalPoster.username,
              spotName: spotName)
    }()

    // MARK: - Initialization

    init(originalPoster: AppUser, spotName: String) {
        self.originalPoster = originalPoster
        self.spotName = spotName

        super.init(frame: .zero)

        setupHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        addSubview(subtitleView)
    }

    private func setupConstraints() {
        subtitleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let subtitleFontSize: CGFloat = 12
    }
}

#if DEBUG
    import SwiftUI
    struct PostHeaderViewPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                let mockHeaderView = PostHeaderView(originalPoster: .init(), spotName: "Teste")
                let vc = UIViewController()
                vc.view.addSubview(mockHeaderView)
                mockHeaderView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }

                return vc
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
