//
//  LoginViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 04/09/21.
//

import AuthenticationServices
import UIKit

class LoginViewController: UIViewController {
    var didSendEventClosure: ((LoginViewController.Event) -> Void)?

    private lazy var skelly: UIImageView = .init()
    private lazy var textLabel: UILabel = .init()
    private lazy var appleButton: ASAuthorizationAppleIDButton = .init(type: .default, style: .white)

    private lazy var appleLoginService: AppleLoginService = .init(contextProvider: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    private func setupViews() {
        skelly.image = UIImage(asset: Assets.Images.loginSkelly)
        skelly.translatesAutoresizingMaskIntoConstraints = false

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "PARÇA, É NOIX.\nPRONTO PRO ROLÊ?"
        textLabel.textAlignment = .center
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: LayoutMetrics.textFontSize)

        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.cornerRadius = LayoutMetrics.loginButtonCornerRadius
        appleButton.addTarget(appleLoginService, action: #selector(appleLoginService.start), for: .touchUpInside)
    }

    func setupHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(skelly)
        view.addSubview(appleButton)
    }

    func setupConstraints() {
        skelly.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
                .offset(LayoutMetrics.skellyTopOffset)
            make.centerXWithinMargins.equalToSuperview()
        }
        textLabel.snp.makeConstraints { make in
            make.centerXWithinMargins.equalToSuperview()
            make.topMargin.equalTo(skelly.snp.bottomMargin)
            make.bottomMargin.equalTo(appleButton.snp.topMargin)
                .offset(LayoutMetrics.textLabelBottomOffset)
        }
        appleButton.snp.makeConstraints { make in
            make.topMargin.equalTo(textLabel.snp.bottomMargin)
                .offset(LayoutMetrics.loginButtonTopOffset)
            make.bottomMargin.equalToSuperview()
                .offset(LayoutMetrics.loginButtonBottomOffset)
            make.leftMargin.equalToSuperview()
                .offset(LayoutMetrics.loginButtonHorizontalOffset)
            make.rightMargin.equalToSuperview()
                .offset(-LayoutMetrics.loginButtonHorizontalOffset)
            make.centerXWithinMargins.equalToSuperview()
        }
    }

    private enum LayoutMetrics {
        static let skellyTopOffset: CGFloat = 20

        static let textFontSize: CGFloat = 40
        static let textLabelBottomOffset: CGFloat = -20

        static let loginButtonCornerRadius: CGFloat = 13
        static let loginButtonHorizontalOffset: CGFloat = 45
        static let loginButtonTopOffset: CGFloat = 20
        static let loginButtonBottomOffset: CGFloat = -40
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
