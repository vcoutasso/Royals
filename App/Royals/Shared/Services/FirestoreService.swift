//
//  FirestoreService.swift
//  Royals
//
//  Created by Vinícius Couto on 16/09/21.
//

import FirebaseFirestore

final class FirestoreService {
    private let db = Firestore.firestore()

    func login() {
        if let user = CurrentUser.shared.user, let uid = user.id {
            do {
                try db.collection(Strings.Names.Firestore.userCollection).document(uid).setData(from: user)
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
}
