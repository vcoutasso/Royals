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
    private var postTitle: String

    private lazy var subtitleView: PostSubtitleView = {
        .init(handle: originalPoster.handle,
              username: originalPoster.username,
              spotName: spotName)
    }()

    private lazy var descriptionView: UIStackView = {
        let title = UILabel()
        title.text = postTitle
        title.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .semibold)
        title.textColor = Assets.Colors.white.color

        let stack = UIStackView(arrangedSubviews: [title, subtitleView])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = LayoutMetrics.verticalStackSpacing

        return stack
    }()

    private lazy var profilePicMiniature: UIImageView = {
        let image = UIImageView(image: Assets.Images.dummyUserImage.image)
        image.makeRounded()

        return image
    }()

    private lazy var headerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profilePicMiniature, descriptionView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = LayoutMetrics.horizontalStackSpacing

        return stack
    }()

    // MARK: - Initialization

    init(originalPoster: AppUser, spotName: String, postTitle: String) {
        self.originalPoster = originalPoster
        self.spotName = spotName
        self.postTitle = postTitle

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
        addSubview(headerView)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let verticalStackSpacing: CGFloat = 5
        static let horizontalStackSpacing: CGFloat = 10
        static let titleFontSize: CGFloat = 18
        static let imageRadius: CGFloat = 36
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
                let mockHeaderView = PostHeaderView(originalPoster: .init(),
                                                    spotName: "Ambiental, Brazil",
                                                    postTitle: "Detonando na Pista")
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
