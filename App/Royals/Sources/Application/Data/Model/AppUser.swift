//
//  AppUser.swift
//  Royals
//
//  Created by Vinícius Couto on 15/09/21.
//

import FirebaseFirestoreSwift

struct AppUser: Identifiable, Codable {
    @DocumentID var id: String?
    var handle: String
    var user: String
    var email: String
    var isAnonymous: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case handle
        case user
        case email
        case isAnonymous
    }
}
