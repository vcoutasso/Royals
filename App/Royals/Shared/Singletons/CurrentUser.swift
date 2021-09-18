//
//  CurrentUser.swift
//  Royals
//
//  Created by Vinícius Couto on 16/09/21.
//

import FirebaseAuth
import FirebaseFirestore

/// Current user singleton
class CurrentUser {
    static var shared: CurrentUser = .init()

    private(set) var user: AppUser?

    private let changeListener: AuthStateDidChangeListenerHandle = Auth.auth()
        .addStateDidChangeListener { _, user in
            CurrentUser.shared.stateDidChange(with: user)
        }

    // MARK: - Private methdos

    private func stateDidChange(with user: User?) {
        guard let user = user else {
            CurrentUser.shared.user = .init()
            return
        }

        CurrentUser.shared.user = instantiateAppUser(with: user)

        FirestoreService().login()
    }

    private func instantiateAppUser(with user: User) -> AppUser {
        .init(id: user.uid,
              handle: user.displayName ?? "",
              username: "@" + String(user.uid.prefix(6)),
              email: user.email ?? "",
              isAnonymous: user.isAnonymous)
    }

    private init() {
        guard let currentUser = Auth.auth().currentUser else { return }

        self.user = instantiateAppUser(with: currentUser)
    }
}
