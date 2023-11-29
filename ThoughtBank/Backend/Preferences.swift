//
//  Preferences.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/29/23.
//

import Foundation

class Preferences {
    
    static func saveCredentials(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "credentials.email")
        UserDefaults.standard.set(password, forKey: "credentials.password")
    }
    
    static func loadCredentials() -> Credentials? {
        if let email = UserDefaults.standard.string(forKey: "credentials.email"),
            let password = UserDefaults.standard.string(forKey: "credentials.password") {
            return Credentials(email: email, password: password)
        }
        return nil
    }
    
    static func deleteCredentials() {
        UserDefaults.standard.set(nil, forKey: "credentials.email")
        UserDefaults.standard.set(nil, forKey: "credentials.password")
    }
    
}

struct Credentials {
    let email: String
    let password: String
}
