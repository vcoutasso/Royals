//
//  FirebaseLoginService.swift
//  Royals
//
//  Created by Vinícius Couto on 05/09/21.
//

import FirebaseFirestore

class FirebaseLoginService {
    func login(email: String, uid: String, completion: @escaping ((Error?) -> Void)) {
        let db = Firestore.firestore()

        db.collection("User").document(uid).setData([
            "email": email,
            "uid": uid,
        ]) { err in
            completion(err)
        }
    }
}
