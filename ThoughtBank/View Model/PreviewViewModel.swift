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
    
    @Published var navigationState: NavigationState = .landing
    
    @Published var user: User? = .sampleExistingUser
    
    // NOTE: I have removed the @Published for these temporarily, because of the way we implemented our stack of cards:
    var feedThoughtIndex: Int = 0
    var depositedThoughtIndex: Int = 0
    var ownedThoughtIndex: Int = 0
    
    @Published var shouldLoadBlocking: Bool = false
    @Published var shouldShowAddThoughtsView: Bool = false
    
    var bannerError: Error?
    
    @Published var feedThoughts: [Thought] = Thought.testingThoughts
    
    func createUser(email: String, password: String) {
        navigationState = .feedThoughts
        user = User.sampleNewUser
    }
    
    func login(email: String, password: String) {
        navigationState = .feedThoughts
        user = User.sampleExistingUser
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
    
    func setScreen(to screen: NavigationState)  {
        navigationState = screen
    }
}
