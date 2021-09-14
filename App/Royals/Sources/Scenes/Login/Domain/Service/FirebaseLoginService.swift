//
//  FirebaseLoginService.swift
//  Royals
//
//  Created by Vinícius Couto on 05/09/21.
//

import FirebaseFirestore

class FirebaseLoginService {
    func login(email: String, displayName: String, uid: String, completion: @escaping ((Error?) -> Void)) {
        let db = Firestore.firestore()

        db.collection(Strings.Names.Firestore.userCollection).document(uid).setData([
            Strings.Names.Firestore.Users.email: email,
            Strings.Names.Firestore.Users.displayName: displayName,
        ]) { err in
            completion(err)
        }
    }
}
