//
//  SHA256.swift
//  Skatable
//
//  Created by Vinícius Couto on 04/09/21.
//

import CryptoKit
import Foundation

@available(iOS 13, *)
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()

    return hashString
}
