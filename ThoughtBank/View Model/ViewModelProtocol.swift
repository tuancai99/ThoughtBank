//
//  ViewModelProtocol.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  Define a view model's structure so that it can be implemented
//  by both the "live" CentralViewModel and the "dummy" PreviewViewModel.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    
    // indicates the type of VM we're looking at (for debugging purposes)
    var description: String { get set }
    
    var navigationState: NavigationState { get set }
    
    var user: User? { get set }
    
    var feedThoughts: [Thought] { get set }
    var ownedThoughts: [Thought] {get}
    var depositedThoughts: [Thought] {get}
    var viewedThoughts: [Thought] {get}
    
    // Index for current stack of cards
    var feedThoughtIndex: Int { get set }
    var depositedThoughtIndex: Int { get set }
    var ownedThoughtIndex: Int { get set }
    
    var shouldLoadBlocking: Bool { get set }
    var shouldShowAddThoughtsView: Bool { get set }
    
    var remainingThoughtsCount: Int { get set }
    
    var bannerError: Error? {get set}
    // General hints:
    // - Use FirebaseManager to interact with Firebase for each function that involves manipulation of data.
    // - Can we call async functions from a synchronous thread? Do we need to spawn a new thread?  (key components: the "Task" wrapper, look into it)
    // - How do we go back to the main thread after handling an async task? (key components: the DispatchQueue.main.async wrapper, look into it)
    
    /// Create a new user.
    ///
    /// Hint: FirebaseManager has a pretty similar function.
    ///
    /// - Parameters
    ///     - email: the email of the user
    ///     - password: the password of the user
    func createUser(email: String, password: String)
    
    /// Log in an existing user.
    ///
    /// Hint: FirebaseManager has a pretty similar function.
    ///
    /// - Parameters
    ///     - email: the email of the user
    ///     - password: the password of the user.
    func login(email: String, password: String)
    
    /// Remove one of the user's thoughts.
    ///
    func popDepositedThought()
    
    /// Create a new thought for the user.
    ///
    /// - Parameters
    ///     - text: the text of the thought inputted by the user
    func createThought(text: String)
    
    /// Deposit another user's thought.
    ///
    /// Hint: 
    ///
    /// - Parameters
    func depositThought()
    
    /// Go to the next thought in the feed.
    ///
    /// Hint: You'll need to manipulate feedThoughts and currentFeedThought
    func goToNextFeedThought()
    
    func currentFeedThought() -> Thought?
    
    /// Go to the next thought in the feed.
    ///
    /// Hint: You'll need to manipulate feedThoughts and currentFeedThought
    func goToNextDepositedThought()
    
    /// Go to the next thought in the feed.
    ///
    /// Hint: You'll need to manipulate feedThoughts and currentFeedThought
    func goToPreviousDepositedThought()
    
    /// Go to the next thought in the feed.
    ///
    /// Hint: You'll need to manipulate feedThoughts and currentFeedThought
    func goToNextOwnedThought()
    
    /// Go to the next thought in the feed.
    ///
    /// Hint: You'll need to manipulate feedThoughts and currentFeedThought
    func goToPreviousOwnedThought()
    
    /// Get all feed thoughts from our database.
    ///
    /// Hint: You'll need to manipulate feedThoughts and currentFeedThought
    func updateFeedThoughts()
    
    func setScreen(to screen: NavigationState)
        
}
