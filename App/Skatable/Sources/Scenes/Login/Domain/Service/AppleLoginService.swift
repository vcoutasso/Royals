//
//  AppleLoginService.swift
//  Skatable
//
//  Created by Vinícius Couto on 05/09/21.
//

import AuthenticationServices
import FirebaseAuth

class AppleLoginService: NSObject {
    // Unhashed nonce.
    private var currentNonce: String?

    private var firebaseService: FirebaseLoginService

    private weak var contextProvider: LoginViewController!

    init(contextProvider: LoginViewController) {
        self.contextProvider = contextProvider
        self.firebaseService = .init()
    }

    @objc func start() {
        startSignInWithAppleFlow()
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
        authorizationController.presentationContextProvider = contextProvider
        authorizationController.performRequests()
    }
}

@available(iOS 13.0, *)
extension AppleLoginService: ASAuthorizationControllerDelegate {
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
                    print(error?.localizedDescription ?? "")
                    return
                }

                guard let user = authResult?.user else { return }
                guard let uid = Auth.auth().currentUser?.uid else { return }

                let email = user.email ?? ""

                self.firebaseService.login(email: email, uid: uid, completion: { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        self.contextProvider.didSendEventClosure?(.login)
                    }
                })
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}
