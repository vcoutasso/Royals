//
//  LoginViewController.swift
//  Skatable
//
//  Created by Vinícius Couto on 04/09/21.
//

import AuthenticationServices
import CryptoKit
import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        setupSignInButtons()
    }

    private func setupSignInButtons() {
        let button = ASAuthorizationAppleIDButton(type: .default, style: .white)
        button.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)

        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.centerWithinMargins.equalToSuperview()
        }
    }

    @objc private func handleSignInWithAppleTapped() {
        performSignIn()
    }

    private func performSignIn() {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])

        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self

        authorizationController.performRequests()
    }

    private func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()

        request.requestedScopes = [.fullName, .email]

        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce

        return request
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}

// Unhashed nonce.
private var currentNonce: String?

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length

    while remainingLength > 0 {
        let randoms: [UInt8] = (0..<16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }

        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }

            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }

    return result
}

// @available(iOS 13, *)
// func startSignInWithAppleFlow() {
//  let nonce = randomNonceString()
//  currentNonce = nonce
//  let appleIDProvider = ASAuthorizationAppleIDProvider()
//  let request = appleIDProvider.createRequest()
//  request.requestedScopes = [.fullName, .email]
//  request.nonce = sha256(nonce)
//
//  let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//  authorizationController.delegate = self
//  authorizationController.presentationContextProvider = self
//  authorizationController.performRequests()
// }

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()

    return hashString
}
