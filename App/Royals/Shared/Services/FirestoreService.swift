//
//  FirestoreService.swift
//  Royals
//
//  Created by Vinícius Couto on 16/09/21.
//

import FirebaseFirestore

final class FirestoreService {
    private let db = Firestore.firestore()

    func saveUserCredentials() {
        if let user = CurrentUser.shared.user, let uid = user.id {
            do {
                try db.collection(Strings.Names.Firestore.userCollection)
                    .document(uid)
                    .setData(from: user)
            } catch {
                print(error)
            }
        }
    }

    func addLocation(_ location: LocationData) {
        if let uid = location.id {
            do {
                try db.collection(Strings.Names.Firestore.locationCollection).document(uid).setData(from: location)
            } catch {
                print(error)
            }
        }
    }

    func getUserCredentials(with uid: String?) {
        db.collection(Strings.Names.Firestore.userCollection).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Could not fetch users")
                return
            }

            if let error = error {
                print(error.localizedDescription)
                return
            }

            let users = documents.compactMap { documentSnapshot -> AppUser? in
                do {
                    return try documentSnapshot.data(as: AppUser.self)
                } catch {
                    return nil
                }
            }

            if let currentUser = users.filter({ $0.id == uid }).first {
                CurrentUser.shared.setAppUser(currentUser)
            }
        }
    }
}
