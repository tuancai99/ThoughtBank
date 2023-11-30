//
//  CentralViewModel.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  Central view model shared by all views.
//  ** Must conform to ViewModelProtocol **
//
//  --- NOTE ---
//  Does NOT handle any UI-specific functionality.
//  Rather, data processing and communications with Firebase are handled here
//  so that the view classes only deal with presentation.
//

import Foundation
import UIKit

class CentralViewModel: ObservableObject, ViewModelProtocol {
    var description: String = "CentralViewModel"
    
    let firebase: FirebaseManager = .manager
    
    @Published var navigationState: NavigationState = .landing
    
    @Published var user: User?
    
    @Published var feedThoughts: [Thought] = []
    var ownedThoughts: [Thought] {
        guard let user = user else { return [] }
        return user.ownedThoughts
    }
    var depositedThoughts: [Thought] {
        guard let user = user else { return [] }
        return user.depositedThoughts
    }
    var viewedThoughts: [Thought] {
        guard let user = user else { return [] }
        return user.viewedThoughts
    }
    
    @Published var feedThoughtIndex: Int = 0
    @Published var depositedThoughtIndex: Int = 0
    @Published var ownedThoughtIndex: Int = 0
    @Published var remainingThoughtsCount: Int = 5
    
    @Published var shouldLoadBlocking: Bool = false
    @Published var shouldShowAddThoughtsView: Bool = false {
        didSet {
            if shouldShowAddThoughtsView {
                navigationState = .add
            } else {
                navigationState = .ownedThoughts
            }
        }
    }
    
    @Published var bannerError: Error? = nil
    
    // GENERAL HINTS:
    // - Use FirebaseManager to interact with Firebase for each function that involves manipulation of data.
    // - Can we call async functions from a synchronous thread? Do we need to spawn a new thread?  (key components: the "Task" wrapper, look into it)
    // - How do we go back to the main thread after handling an async task? (key components: the DispatchQueue.main.async wrapper, look into it)
    
    /**
     Performs the registration of a new user into our database and all the essential logic that follows.
     
     1. FirebaseManager has a pretty similar function. It will do most of the work for you, pay attention to the fact that it 'throws'.
     2. We have a local 'user' variable, we probably want to set instantiate  that don't we.
     3. We have a local 'shouldLoadBlocking' variable which indicates whether we want to present a loading spinner, turn that on while it is still being processed in the backend, and turn it off after it's complete (regardless of success or failure).
     
     - Parameters:
     - email: the email of the user
     - password: the password of the user
     **/
    func createUser(email: String, password: String) {
        shouldLoadBlocking = true
        Task {
            do {
                let fetchedUser = try await firebase.createUser(email: email, password: password)
                await MainActor.run {
                    user = fetchedUser
                    shouldLoadBlocking = false
                    setScreen(to: .feedThoughts)
                }
            } catch {
                await MainActor.run {
                    shouldLoadBlocking = false
                    bannerError = .authenticationFailure
                }
            }
        }
    }
    
    /**
     Login of an existing user and all the essential logic that follows.
     
     1. FirebaseManager has a pretty similar function. It will do most of the work for you, pay attention to the fact that it 'throws'.
     2. We have a local 'user' variable, we probably want to set instantiate  that don't we.
     3. We have a local 'shouldLoadBlocking' variable which indicates whether we want to present a loading spinner, turn that on while it is still being processed in the backend, and turn it off after it's complete (regardless of success or failure).
     
     - Parameters:
     - email: the email of the user
     - password: the password of the user
     **/
    func login(email: String, password: String) {
        shouldLoadBlocking = true
        Task {
            do {
                let fetchedUser = try await firebase.login(email: email, password: password)
                await MainActor.run {
                    Preferences.saveCredentials(email: email, password: password)
                    user = fetchedUser
                    shouldLoadBlocking = false
                    setScreen(to: .feedThoughts)
                }
            } catch {
                await MainActor.run {
                    shouldLoadBlocking = false
                    bannerError = .authenticationFailure
                }
            }
        }
    }
    
    /**
     Remove the specified thought from our online database and then locally IF that succeeds.
     
     1. FirebaseManager has a pretty useful function (updateUserData). It will do most of the work for you on the database, pay attention to the fact that it 'throws' and is 'async'.
     2. We have a local 'currentDespositedThought' variable, we probably want to edit that if removing succeeds. Make sure 'depositedThoughtIndex' doesn't exceed the new array size.
     3. We have a local 'shouldLoadBlocking' variable which indicates whether we want to present a loading spinner, turn that on while it is still being processed in the backend, and turn it off after it's complete (regardless of success or failure).
     
     - Parameters:
     - thought: a struct object representing all the information about the thought we want to remove
     **/
    func popDepositedThought() {
        if depositedThoughtIndex < 0 || depositedThoughtIndex >= depositedThoughts.count {
            print("Error: Deposited Thought Index is OOB")
            return
        }
        
        let thought: Thought = depositedThoughts[depositedThoughtIndex]
        guard let user = user else {
            return
        }
        
        shouldLoadBlocking = true
        Task {
            do {
                // POP DEPOSITED THOUGHT TO THE ONLINE DB
                // create a deep copy + deposit thought to the copy and post
                let duplicate = user.duplicate()
                if (duplicate.depositedThoughts.count != 0) {
                    duplicate.popDepositedThought(thought: thought)
                    try await firebase.updateUserData(user: duplicate)

                    // POP DEPOSITED THOUGHT LOCALLY
                    await MainActor.run(body: {
                        user.popDepositedThought(thought: thought)
                        if depositedThoughtIndex > 0 && depositedThoughtIndex >= depositedThoughts.count {
                            depositedThoughtIndex -= 1
                        } else {
                            depositedThoughtIndex = 0
                        }
                        shouldLoadBlocking = false
                    })
                } else {
                    print("Error: Deposited Thought Arr is empty")
                    return
                }

            } catch {
                print("Error depositing thought: \(error)")
            }
        }
    }
    
    /**
     Add a thought with the specified text to our online database and then locally IF that succeeds.
     
     1. FirebaseManager has pretty useful functions (addThought and updateUserData). It will do most of the work for you on the database, pay attention to the fact that it 'throws' and is 'async' and what it returns.
     2. We have a local 'ownedThoughts' variable, we probably want to edit that if creation succeeds AND this thought was the first ever created.
     3. We have a local 'shouldLoadBlocking' variable which indicates whether we want to present a loading spinner, turn that on while it is still being processed in the backend, and turn it off after it's complete (regardless of success or failure).
     
     - Parameters:
     - text: the thought's text
     **/
    func createThought(text: String) {
        guard let user = user else {
            bannerError = .notLoggedIn
            return
        }
        
        shouldLoadBlocking = true
        Task {
            do {
                let thought = try await firebase.addThought(content: text, userID: user.userID)
                await MainActor.run(body: {
                    
                    user.ownedThoughts.append(_:thought)
                    shouldShowAddThoughtsView = false
                    shouldLoadBlocking = false
                    
                })
                try await firebase.updateUserData(user: user)
            } catch {
                await MainActor.run(body: {
                    
                    shouldLoadBlocking = false
                    bannerError = .uploadError
                    
                })
                print("error")
            }
            
        }
        
    }
    
    /**
     Add the given thought to our list of deposited thoughts through our online database and then locally IF that succeeds.
     
     1. FirebaseManager has a pretty useful function (updateUserData). It will do most of the work for you on the database, pay attention to the fact that it 'throws' and is 'async' and what it returns.
     2. We have a local 'depositedThoughts' variable, we probably want to edit that if removing succeeds.
     3. We have a local 'shouldLoadBlocking' variable which indicates whether we want to present a loading spinner, turn that on while it is still being processed in the backend, and turn it off after it's complete (regardless of success or failure).
     
     - Parameters:
     - thought: the thought we want to deposit
     **/
    func depositThought() {
        guard let user = user else {
            return
        }
        shouldLoadBlocking = true
        Task {
            do {
                
                if feedThoughtIndex >= feedThoughts.count || feedThoughtIndex < 0 {
                    // error
                    print("Attempted to retrieve index \(feedThoughtIndex) from feedThoughts (length \(feedThoughts.count))")
                    await MainActor.run(body: {
                        shouldLoadBlocking = false
                    })
                    return
                } else {
                    print("Deposit thought: " + feedThoughts[feedThoughtIndex].content)
                }
                
                let unwrappedThought = feedThoughts[feedThoughtIndex]
                
                // ADD DEPOSITED THOUGHT TO THE ONLINE DB
                // create a deep copy + deposit thought to the copy and post
                let duplicate = user.duplicate()
                duplicate.depositThought(thought: unwrappedThought)
                try await firebase.updateUserData(user: duplicate)
                
                // ADD DEPOSITED THOUGHT LOCALLY
                await MainActor.run(body: {
                    user.depositThought(thought: unwrappedThought)
                    // Go to next feed thought:
                    feedThoughts.removeAll(where: { $0 == unwrappedThought })
                    //feedThoughtIndex += 1

                    shouldLoadBlocking = false
                })
                
            } catch {
                bannerError = .uploadError
                print("Error depositing thought: \(error)")
                await MainActor.run(body: {
                    shouldLoadBlocking = false
                })
            }
        }
    }
    
    /**
     Present the next thought from our list of feed thoughts.
     
     1. Use the variable 'feedThoughtIndex' to specify the new active thought.
     2. Be sure to check for bounds such that we don't reference the nonexistent thought.
     3. IMPORTANT: ensure that the thoughts we are are moving past are removed from the feedThoughts array AND added to the viewedThoughts in our user object. This ensures that we never revisit a thought we have already viewed.
     
     **/
    func goToNextFeedThought() {
        guard let user = user else { self.bannerError = .notLoggedIn; return }
        // we can let it overflow by 1,
        // since we can go past the last thought for this view
        if (feedThoughtIndex < feedThoughts.count) {
            
            Task {
                do {
                    let popped = currentFeedThought()!
                    
                    let duplicate = user.duplicate()
                    duplicate.appendViewedThought(thought: popped)
                    try await firebase.updateUserData(user: duplicate)
                    
                    DispatchQueue.main.async {
                        user.appendViewedThought(thought: popped)
                        //feedThoughtIndex += 1
                        self.feedThoughts.removeAll(where: { $0 == popped })
                        self.shouldLoadBlocking = false
                    }
                } catch {
                    print("Unsuccessfully tried to go to next thought.")
                    bannerError = .uploadError
                }
            }

        }
    }
    
    /**
     Helper function that returns the feed item being looked at. Returns nil when no feed thought exists.
     */
    func currentFeedThought() -> Thought? {
        return feedThoughts[feedThoughtIndex]
    }
    
    func feedThoughtsIsEmpty() -> Bool {
        return feedThoughts.isEmpty
    }
    
    
    /**
     Present the next thought from our list of deposited thoughts which is stored in our user object.
     
     1. Use the variable 'depositedThoughtIndex' to specify the new active thought.
     2. Be sure to check for bounds such that we don't reference a nonexistent thought.
     
     **/
    func goToNextDepositedThought() {
        let count = depositedThoughts.count
        if (depositedThoughtIndex < count - 1) {
            depositedThoughtIndex += 1
        }
        
    }
    
    /**
     Present the previous thought from our list of deposited thoughts which is stored in our user object.
     
     1. Use the variable 'depositedThoughtIndex' to specify the new active thought.
     2. Be sure to check for bounds such that we don't reference a nonexistent thought.
     
     **/
    func goToPreviousDepositedThought() {
        if (depositedThoughtIndex > 0) {
            depositedThoughtIndex -= 1
        }
        
    }
    
    /**
     Helper function that returns the deposited item being looked at. Returns nil when no deposited thought exists.
     */
    func currentDepositedThought() -> Thought? {
        return user?.depositedThoughts[depositedThoughtIndex]
    }
    
    func depositedThoughtsIsEmpty() -> Bool {
        guard let deposited = user?.depositedThoughts else { return true }
        return deposited.isEmpty
    }
    
    /**
     Present the next thought from our list of owned thoughts which is stored in our user object.
     
     1. Use the variable 'depositedThoughtIndex' to specify the new active thought.
     2. Be sure to check for bounds such that we don't reference a nonexistent thought.
     
     **/
    func goToNextOwnedThought() {
        if let user = user {
            let thoughts = user.ownedThoughts
            if ownedThoughtIndex < thoughts.count - 1 {
                ownedThoughtIndex += 1
            }
        }
    }
        
    /**
     Present the previous thought from our list of owned thoughts which is stored in our user object.
     
     1. Use the variable 'depositedThoughtIndex' to specify the new active thought.
     2. Be sure to check for bounds such that we don't reference a nonexistent thought.
     
     **/
    func goToPreviousOwnedThought() {
        if (ownedThoughtIndex > 0) {
            ownedThoughtIndex -= 1
        }
    }
    
    /**
     Helper function that returns the owned item being looked at. Returns nil when no owned thought exists.
     */
    func currentOwnedThought() -> Thought? {
        return user?.ownedThoughts[ownedThoughtIndex]
    }
    
    func ownedThoughtsIsEmpty() -> Bool {
        guard let owned = user?.ownedThoughts else { return true }
        return owned.isEmpty
    }
    
    
    /**
     Set the feed thoughts array to an update-to-date collection. of our feed thoughts
     
     1. FirebaseManager has a pretty useful function (fetch). It will do most of the work for you on the database, pay attention to the fact that it 'throws' and is 'async' and what it returns.
     2. IMPORTANT: the feed thoughts displayed should exclude the thoughts the user have viewed (found in viewedThoughts of our user object), make sure we are excluding them before setting our feedThoughts.
     3. IMPORTANT: we should also exclude thoughts written by the user themself.
     
     
     **/
    func updateFeedThoughts() {
        guard let user = user else {
            bannerError = .notLoggedIn
            return
        }
        
        shouldLoadBlocking = true

        Task {
            
            do {
                let response = try await firebase.fetchThoughts(filterGroup: [])
                    .filter { thought in
                        let isViewed = user.viewedThoughts.contains { $0.id == thought.id }
                        let isOwned = thought.userID == user.userID
                        
                        return !isOwned && !isViewed
                    }
                
                await MainActor.run {
                    feedThoughts = response
                }
                
            } catch {
                bannerError = .fetchingError
                print("Error updating feed!")
            }
            await MainActor.run {
                shouldLoadBlocking = false
            }

        }
    }
    
    func setScreen(to screen: NavigationState)  {
        navigationState = screen
    }
    
    func getFlippedIndex(i: Int, thoughtIndex: Int, count: Int) -> Int {
        return (count - i - 1) + thoughtIndex
    }

}

