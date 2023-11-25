//
//  PreviewViewModel.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  Separate view model implementation for generating previews.
//
//  This is not used by the live app, but can assist in providing dummy
//  data to the previews (which can be helpful for debugging the UI).
//
//  It also ensures that the previews are not actually making any calls
//  to external APIs such as Firebase.
//

import Foundation

class PreviewViewModel: ObservableObject, ViewModelProtocol {
    var description: String = "PreviewViewModel"
    
    @Published var navigationState: NavigationState = .landing {
        didSet {
            
        }
    }
    
    @Published var user: User? = User(alias: "car99", userID: "1234", email: "smith@gmail.com", ownedThoughts: Thought.testingThoughts, depositedThoughts: Thought.testingThoughts, viewedThoughts: [])
    
    // NOTE: I have removed the @Published for these temporarily, because 
    var feedThoughtIndex: Int = 0
    var depositedThoughtIndex: Int = 0
    var ownedThoughtIndex: Int = 0
    @Published var shouldLoadBlocking: Bool = false
    @Published var feedThoughts: [Thought] = Thought.testingThoughts
    
    func createUser(email: String, password: String) {
        navigationState = .feedThoughts
        user = User(alias: "NewUser01", userID: "abc123", email: "newuser@example.com", ownedThoughts: [
            
        ], depositedThoughts: [
            
        ], viewedThoughts: [
            
        ])
    }
    
    func login(email: String, password: String) {
        navigationState = .feedThoughts
        user = User(alias: "ExistingUser03", userID: "def456", email: "existinguser@example.com", ownedThoughts: [
            Thought(documentID: "f", content: "Thinking is hard", userID: "def456", timestamp: Date()),
            Thought(documentID: "g", content: "I know that the human being and fish can coexist peacefully.", userID: "def456", timestamp: Date()),
            Thought(documentID: "h", content: "I should probably call mom.", userID: "def456", timestamp: Date())
        ], depositedThoughts: [
            Thought(documentID: "j", content: "Before you marry a person, make them use a computer with slow internet to see who they really are.", userID: "aaa000", timestamp: Date()),
            Thought(documentID: "j", content: "If you think nobody cares if you're alive, try missing a couple of car payments.", userID: "bbb111", timestamp: Date())
        ], viewedThoughts: [
            Thought(documentID: "i", content: "The existing user has already seen this thought. It should not be visible in the feed.", userID: "pqr567", timestamp: Date())
        ])
    }
    
    func popDepositedThought(thought: Thought?) {
        if user == nil {
            print("ERROR: User is nil")
            return
        }
        
        if depositedThoughtIndex < user!.depositedThoughts.count {
            user!.depositedThoughts.remove(at: depositedThoughtIndex)
        } else {
            print("ERROR: Card stack index out of bounds")
        }
        
        if user!.depositedThoughts.count != 0 && depositedThoughtIndex >= user!.depositedThoughts.count {
            depositedThoughtIndex -= 1
        } else if user!.depositedThoughts.count != 0 && depositedThoughtIndex == 0 {
            depositedThoughtIndex += 1
        }
    }
    
    func createThought(text: String) {
        if user == nil {
            print("ERROR: User is nil")
            return
        }
        user!.ownedThoughts.append(Thought(documentID: Date().timeIntervalSince1970.description, content: text, userID: user!.userID, timestamp: Date()))
    }
    
    func depositThought(thought: Thought?) {
        if user == nil || thought == nil {
            print("ERROR: User or thought is nil")
            return
        }
        
        user!.depositedThoughts.append(thought!)
        goToNextFeedThought()
    }
    
    func goToNextFeedThought() {
        if (feedThoughtIndex < feedThoughts.count) {
            feedThoughtIndex += 1
        }
    }
    
    func currentFeedThought() -> Thought? {
        return feedThoughts[feedThoughtIndex]
    }
    
    func goToNextDepositedThought() {
        if user == nil {
            print("ERROR: User is nil")
            return
        }
        
        if (depositedThoughtIndex < user!.depositedThoughts.count - 1) {
            depositedThoughtIndex += 1
        }
    }
    
    func goToPreviousDepositedThought() {
        if user == nil {
            print("ERROR: User is nil")
            return
        }
        
        if (depositedThoughtIndex > 0) {
            depositedThoughtIndex -= 1
        }
    }
    
    func goToNextOwnedThought() {
        if user == nil {
            print("ERROR: User is nil")
            return
        }
        
        if (ownedThoughtIndex < user!.ownedThoughts.count - 1) {
            ownedThoughtIndex += 1
        }
    }
    
    func goToPreviousOwnedThought() {
        if user == nil {
            print("ERROR: User is nil")
            return
        }
        
        if (ownedThoughtIndex > 0) {
            ownedThoughtIndex -= 1
        }
    }
    
    func updateFeedThoughts() {
    }
}
