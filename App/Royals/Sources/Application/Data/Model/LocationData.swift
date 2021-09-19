//
//  LocationData.swift
//  Royals
//
//  Created by Bruno Thuma on 19/09/21.
//

import FirebaseFirestoreSwift

struct LocationData: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var latitude: Double
    var longitude: Double
    var street: String
    var city: String
    var neighborhood: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case latitude
        case longitude
        case street
        case city
        case neighborhood
    }
}
