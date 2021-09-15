//
//  LoginViewController.swift
//  Royals
//
//  Created by Vinícius Couto on 04/09/21.
//

import AuthenticationServices
import UIKit

final class LoginViewController: UIViewController {
    var didSendEventClosure: ((LoginViewController.Event) -> Void)?

    private lazy var skellyImageView: UIImageView = .init()
    private lazy var calloutLabel: UILabel = .init()
    private lazy var appleButton: ASAuthorizationAppleIDButton = .init(type: .default, style: .white)

    private lazy var appleLoginService: AppleLoginService = .init(contextProvider: self)
    private lazy var guestLoginService: GuestLoginService = .init(contextProvider: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    private func setupViews() {
        skellyImageView.image = UIImage(asset: Assets.Images.loginSkelly)
        skellyImageView.contentMode = .scaleAspectFit

        calloutLabel.translatesAutoresizingMaskIntoConstraints = false
        calloutLabel.text = Strings.Localizable.LoginScene.Callout.text
        calloutLabel.textAlignment = .center
        calloutLabel.lineBreakMode = .byWordWrapping
        calloutLabel.numberOfLines = 0
        calloutLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: LayoutMetrics.textFontSize)
        let guestLoginGesture = UITapGestureRecognizer(target: guestLoginService,
                                                       action: #selector(guestLoginService.start))
        guestLoginGesture.numberOfTouchesRequired = 1
        guestLoginGesture.numberOfTapsRequired = 2
        calloutLabel.isUserInteractionEnabled = true
        calloutLabel.addGestureRecognizer(guestLoginGesture)

        appleButton.cornerRadius = LayoutMetrics.loginButtonCornerRadius
        appleButton.addTarget(appleLoginService, action: #selector(appleLoginService.start), for: .touchUpInside)
    }

    func setupHierarchy() {
        view.addSubview(calloutLabel)
        view.addSubview(skellyImageView)
        view.addSubview(appleButton)
    }

    func setupConstraints() {
        skellyImageView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
                .offset(LayoutMetrics.verticalPadding)
            make.centerXWithinMargins.equalToSuperview()
        }

        calloutLabel.snp.makeConstraints { make in
            make.top.equalTo(skellyImageView.snp.bottom)
            make.centerXWithinMargins.equalToSuperview()
        }

        appleButton.snp.makeConstraints { make in
            make.top.equalTo(calloutLabel.snp.bottom)
                .offset(LayoutMetrics.verticalPadding)
            make.leftMargin.equalToSuperview()
                .offset(LayoutMetrics.horizontalPadding)
            make.rightMargin.equalToSuperview()
                .offset(-LayoutMetrics.horizontalPadding)
            make.centerXWithinMargins.equalToSuperview()
            make.height.equalTo(LayoutMetrics.loginButtonHeight)
        }
    }

    private enum LayoutMetrics {
        static let textFontSize: CGFloat = 40

        static let loginButtonHeight: CGFloat = 50
        static let loginButtonCornerRadius: CGFloat = 13

        static let verticalPadding: CGFloat = 30
        static let horizontalPadding: CGFloat = 45
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

extension LoginViewController {
    enum Event {
        case login
    }
}

#if DEBUG
    import SwiftUI
    struct LoginViewControllerPreview: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }

        struct ContentView: UIViewControllerRepresentable {
            func makeUIViewController(context: Context) -> UIViewController {
                return LoginViewController()
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        }
    }
#endif
