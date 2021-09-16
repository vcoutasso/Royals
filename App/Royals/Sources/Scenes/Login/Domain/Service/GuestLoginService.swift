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

    // MARK: - Initialization

    init(contextProvider: LoginViewController) {
        self.contextProvider = contextProvider
    }

    // MARK: - Public methods

    @objc func start() {
        Auth.auth().signInAnonymously { _, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }

            self.contextProvider.didSendEventClosure?(.login)
        }
    }
}
