//
//  CurrentUser.swift
//  Royals
//
//  Created by Vinícius Couto on 16/09/21.
//

import FirebaseAuth
import FirebaseFirestore

/// Singleton current user class
class CurrentUser {
    static var shared: CurrentUser = .init()

    private(set) var user: AppUser?

    private let changeListener: AuthStateDidChangeListenerHandle = Auth.auth()
        .addStateDidChangeListener { _, user in
            guard let user = user else {
                CurrentUser.shared.user = nil
                return
            }

            CurrentUser.shared.authDidChange(user)
        }

    private let authDidChange: (User) -> Void = { user in
        CurrentUser.shared.user = AppUser(id: user.uid,
                                          handle: user.displayName ?? "",
                                          user: String(user.uid.prefix(6)),
                                          email: user.email ?? "",
                                          isAnonymous: user.isAnonymous)

        FirestoreService().login()
    }

    private init() {}
}
