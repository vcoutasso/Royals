//
//  LoginViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 04/09/21.
//

import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import UIKit

class LoginViewController: UIViewController {
    // Unhashed nonce.
    fileprivate var currentNonce: String?

    var didSendEventClosure: ((LoginViewController.Event) -> Void)?

    let skelly: UIImageView = .init()
    let textLabel: UILabel = .init()
    let appleButton: ASAuthorizationAppleIDButton = .init(type: .continue, style: .white)

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
        textLabel.font = UIFont(font: Fonts.SpriteGraffiti.regular, size: 40)

        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.cornerRadius = 13
        appleButton.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
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

    @available(iOS 13, *)
    @objc private func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    private enum LayoutMetrics {
        static let skellyTopOffset: CGFloat = 20
        static let textLabelBottomOffset: CGFloat = -20
        static let loginButtonHorizontalOffset: CGFloat = 45
        static let loginButtonTopOffset: CGFloat = 20
        static let loginButtonBottomOffset: CGFloat = -40
    }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idTokenString,
                rawNonce: nonce
            )
            Auth.auth().signIn(with: credential) { authResult, error in
                if error != nil {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print(error?.localizedDescription ?? "")
                    return
                }
                guard let user = authResult?.user else { return }
                let email = user.email ?? ""
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let db = Firestore.firestore()
                db.collection("User").document(uid).setData([
                    "email": email,
                    "uid": uid,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        self.didSendEventClosure?(.login)
                    }
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
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
