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

    private let firestoreService: FirestoreService = .init()

    // MARK: - Private methdos

    private func stateDidChange(with user: User?) {
        guard let user = user else {
            CurrentUser.shared.user = .init()
            return
        }

        firestoreService.getUserCredentials(with: user.uid)
    }

    private func instantiateAppUser(with user: User) -> AppUser {
        .init(id: user.uid,
              handle: user.displayName ?? "",
              username: "@" + String(user.uid.prefix(6)),
              email: user.email ?? "",
              isAnonymous: user.isAnonymous)
    }

    // MARK: - Initialization

    private init() {
        guard let currentUser = Auth.auth().currentUser else { return }

        // Initialize with default user data
        self.user = instantiateAppUser(with: currentUser)

        // Try to fetch updated data from firestore
        firestoreService.getUserCredentials(with: currentUser.uid)
    }

    // MARK: - Public methods

    func updateUserData(handle: String?, username: String?) {
        if let handle = handle, !handle.isEmpty {
            CurrentUser.shared.user?.handle = handle
        }

        if let username = username, !username.isEmpty {
            let newUsername = username.first! == "@" ? username : "@" + username
            CurrentUser.shared.user?.username = newUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        firestoreService.saveUserCredentials()
    }

    // FIXME: Hmm doesn't seem very safe amirite
    func setAppUser(_ user: AppUser) {
        CurrentUser.shared.user = user
    }
}
