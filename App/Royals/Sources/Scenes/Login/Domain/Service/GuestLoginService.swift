//
//  GuestLoginService.swift
//  Royals
//
//  Created by Vinícius Couto on 15/09/21.
//

import AuthenticationServices
import FirebaseAuth

final class GuestLoginService: NSObject {
    // MARK: - Private attributes

    private weak var contextProvider: LoginViewController!
    private var firebaseService: FirebaseLoginService = .init()

    // MARK: - Initialization

    init(contextProvider: LoginViewController) {
        self.contextProvider = contextProvider
    }

    // MARK: - Public methods

    @objc func start() {
        Auth.auth().signInAnonymously { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }

            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous
            let uid = user.uid

            self.contextProvider.didSendEventClosure?(.login)
        }
    }
}
