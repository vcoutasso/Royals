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
    var username: String
    var email: String
    var isAnonymous: Bool

    // Anonymous user initialization.
    init() {
        self.id = nil
        self.handle = Strings.Localizable.UserModel.FallbackData.handle
        self.username = "@" + handle.lowercased()
        self.email = ""
        self.isAnonymous = true
    }

    init(id: String, handle: String, username: String, email: String, isAnonymous: Bool) {
        self.id = id
        self.handle = handle
        self.username = username
        self.email = email
        self.isAnonymous = isAnonymous
    }

    enum CodingKeys: String, CodingKey {
        case id
        case handle
        case username
        case email
        case isAnonymous
    }
}
