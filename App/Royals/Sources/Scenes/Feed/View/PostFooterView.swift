//
//  PostFooterView.swift
//  Royals
//
//  Created by Vinícius Couto on 19/09/21.
//

import UIKit

// FIXME: Tread carefully, O mighty developer, for this code is broken AF
class PostFooterView: UIStackView {
    // MARK: - Private attributes

    private var tags: [String]
    private var totalComments: Int

    private lazy var commentsButton: UIButton = {
        let font = UIFont.systemFont(ofSize: LayoutMetrics.commentsButtonIconFontSize, weight: .semibold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let icon = UIImage(systemName: Strings.Names.Icons.chatBubble, withConfiguration: configuration)

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let title = formatter.string(from: NSNumber(value: totalComments))

        let btn = UIButton()
        btn.setImage(icon, for: .normal)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(Assets.Colors.darkSystemGray1.color, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: LayoutMetrics.commentsButtonTitleFontSize, weight: .semibold)
        btn.tintColor = Assets.Colors.darkSystemGray1.color

        return btn
    }()

    private lazy var tagsScrollView: UIScrollView = {
        let scroll = UIScrollView()
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false

        for tag in tags {
            let tagButton = UIButton()
            tagButton.setTitle(tag, for: .normal)
            tagButton.setTitleColor(Assets.Colors.white.color, for: .normal)
            tagButton.titleLabel?.font = .systemFont(ofSize: LayoutMetrics.tagButtonTitleFontSize, weight: .bold)
            tagButton.backgroundColor = .clear
            tagButton.layer.cornerRadius = LayoutMetrics.tagButtonCornerRadius
            tagButton.layer.borderWidth = LayoutMetrics.tagButtonBorderWidth
            tagButton.layer.borderColor = Assets.Colors.white.color.cgColor
            tagButton.translatesAutoresizingMaskIntoConstraints = false

            stack.addSubview(tagButton)
        }

        scroll.addSubview(stack)

        stack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
//            make.width.equalTo(300)
        }

        return scroll
    }()

    init(tags: [String], totalComments: Int = 2340) {
        self.tags = tags
        self.totalComments = totalComments
        super.init(frame: .zero)

        setupViews()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupViews() {
        let separator = SeparatorView()

        axis = .horizontal
        alignment = .center
        spacing = LayoutMetrics.stackSpacing

        addArrangedSubview(commentsButton)
        addArrangedSubview(separator)
        addArrangedSubview(tagsScrollView)

        separator.snp.makeConstraints { make in
            make.width.equalTo(LayoutMetrics.separatorWidth)
            make.height.equalToSuperview()
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let commentsButtonIconFontSize: CGFloat = 16
        static let commentsButtonTitleFontSize: CGFloat = 14
        static let tagButtonCornerRadius: CGFloat = 13
        static let tagButtonBorderWidth: CGFloat = 2
        static let tagButtonTitleFontSize: CGFloat = 12
        static let stackSpacing: CGFloat = 15
        static let separatorWidth: CGFloat = 1
    }
}

#if DEBUG
    import SwiftUI
    struct PostFooterViewPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                let mockHeaderView = PostFooterView(tags: ["360 ollie", "impossible", "drop in"], totalComments: 2480)
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
