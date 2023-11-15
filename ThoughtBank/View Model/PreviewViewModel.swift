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
    
    @Published var navigationState: NavigationState = .landing
    
    @Published var user: User?
    @Published var feedThoughts: [Thought] = [
        Thought(documentID: "a", content: "This is one thought", userID: "User1", timestamp: Date()),
        Thought(documentID: "b", content: "This is a second thought.", userID: "User2", timestamp: Date()),
        Thought(documentID: "c", content: "This is a very long thought. Think about how the UI should handle thoughts like these. Should it be scrollable? Should it be truncated? Should it be in another view? These are important design decisions that you need to make while developing an app that recieves user input which can be erratic and unexpected. But anyways, hope this extremely long thought doesn't mess things up.", userID: "VeryLongUsernameThatWillProbablyTestUIBoundaries", timestamp: Date()),
        Thought(documentID: "d", content: "This is a much smaller thought in comparison.", userID: "User4", timestamp: Date()),
        Thought(documentID: "e", content: "This 👇 thought 💭 has ☺️ special ✨ characters 😍. \tIt also has unusual line\n\nbreaks\nthat\nmight\nmake\nthings\nlook\na\nbit\nweird.", userID: "User5", timestamp: Date())
    ]
    @Published var currentFeedThought: Thought?
    @Published var currentFeedIndex: Int = 0
    
    func createUser(email: String, password: String) {
        navigationState = .main
        currentFeedIndex = 0
        currentFeedThought = feedThoughts[currentFeedIndex]
    }
    
    func login(email: String, password: String) {
        navigationState = .main
        currentFeedThought = feedThoughts[currentFeedIndex]
    }
    
    func popDepositedThought(thought: Thought) {
        
    }
    
    func createThought(text: String) {
        
    }
    
    func depositThought(thought: Thought) {
        
    }
    
    func goToNextThought() {
        if (currentFeedIndex < feedThoughts.count) {
            currentFeedIndex += 1
            currentFeedThought = feedThoughts[currentFeedIndex]
        }
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getFeedThoughts() -> [Thought] {
        return self.feedThoughts
    }
    
    func getCurrentThought() -> Thought? {
        return self.currentFeedThought
    }
    
    var description: String = "PreviewViewModel"
    
}
