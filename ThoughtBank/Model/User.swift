//
//  User.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  A representation of a user with all the necessary parameters
//  and functions.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class User: ObservableObject, QueryItem {
    var documentID: String
        
    // TODO: add init(), functions, and decoder/encoder.
    var alias: String
    var userID: String
    var email: String
    
    @Published var ownedThoughts: [Thought]
    @Published var depositedThoughts: [Thought]
    @Published var viewedThoughts: [Thought]

    
    init(alias: String, userID: String, email: String, ownedThoughts: [Thought], depositedThoughts: [Thought], viewedThoughts: [Thought]) {
        
        self.documentID = userID
        
        self.alias = alias
        self.userID = userID
        self.email = email
        self.ownedThoughts = ownedThoughts
        self.depositedThoughts = depositedThoughts
        self.viewedThoughts = viewedThoughts
        
    }
    
    func popDepositedThought(thought: Thought) { }
    
    func createThought(text: String) { }
    
    func depositThought(thought: Thought) { }
    
    func appendViewedThought(thought: Thought) { }
/*
    func encode(to encoder: Encoder) throws {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
        } catch {
            print("Error encoding User object into JSON object!")
        }
        
    }
*/
    
}


class Alias {
    static func generateUniqueAlias() -> String {
        return "Dolphin199"
    }
}
