//
//  Credentials.swift
//  Skatable
//
//  Created by Vinícius Couto on 09/09/21.
//

import Foundation

func saveUserCredentials(userCredentials: String) {
    UserDefaults.standard.set(userCredentials, forKey: Strings.Names.Keys.uid)
}

func retrieveUserCredentials() -> String? {
    guard let data = UserDefaults.standard.value(forKey: Strings.Names.Keys.uid) as? String
    else {
        print("Could not find User Credentials for key \(Strings.Names.Keys.uid)")
        return nil
    }
    return data
}

func resetUserCredentials() {
    UserDefaults.standard.removeObject(forKey: Strings.Names.Keys.uid)
}
