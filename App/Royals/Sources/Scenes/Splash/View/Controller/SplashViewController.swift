//
//  SplashViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 16/09/21.
//

import UIKit

class SplashViewController: UIViewController {
    // MARK: - Private attributes

    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView(image: UIImage(asset: Assets.Images.splashLogo))

        return logo
    }()

    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        view.addSubview(logoImageView)
    }

    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

#if DEBUG
    import SwiftUI
    struct SplashViewControllerPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                SplashViewController()
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
