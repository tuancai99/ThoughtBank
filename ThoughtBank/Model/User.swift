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
        
    var alias: String
    var userID: String
    var email: String
    
    @Published var ownedThoughts: [Thought] {
        didSet {
            self.objectWillChange.send()
        }
    }
    @Published var depositedThoughts: [Thought] {
        didSet {
            self.objectWillChange.send()
        }
    }
    @Published var viewedThoughts: [Thought] {
        didSet {
            self.objectWillChange.send()
        }
    }

    
    init(alias: String, userID: String, email: String, ownedThoughts: [Thought], depositedThoughts: [Thought], viewedThoughts: [Thought]) {
        
        self.documentID = userID
        
        self.alias = alias
        self.userID = userID
        self.email = email
        
        self.ownedThoughts = ownedThoughts
        self.depositedThoughts = depositedThoughts
        self.viewedThoughts = viewedThoughts
        
    }
    
    func popDepositedThought(thought: Thought) {
        depositedThoughts.removeAll(where: { $0.id == thought.id })
    }
    
    func createThought(thought: Thought) {
        ownedThoughts.append(thought)
    }
    
    func depositThought(thought: Thought) { 
        depositedThoughts.append(thought)
    }
    
    func appendViewedThought(thought: Thought) {
        viewedThoughts.append(thought)
    }
    
    func duplicate() -> User {
        return User(
        alias: self.alias,
        userID: self.userID,
        email: self.email,
        ownedThoughts: self.ownedThoughts,
        depositedThoughts: self.depositedThoughts,
        viewedThoughts: self.viewedThoughts
        )
    }
    
    static var sampleNewUser = User(
        alias: "NewUser03",
        userID: "def456",
        email: "smith@gmail.com",
        ownedThoughts: [],
        depositedThoughts: [],
        viewedThoughts: []
    )
    
    static var sampleExistingUser = User(
        alias: "ExistingUser03",
        userID: "xoxJc0UkFqt7ApHOd74a",
        email: "existinguser@example.com",
        ownedThoughts: Thought.testingThoughts,
        depositedThoughts: Thought.testingThoughts,
        viewedThoughts: Thought.testingThoughts
    )
    
}


class Alias {
    static func generateUniqueAlias() -> String {
        return "Dolphin199"
    }
}
