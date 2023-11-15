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
    
    @Published var navigationState: NavigationState = .landing
    
    @Published var user: User?
    @Published var feedThoughts: [Thought] = []
    @Published var currentFeedThought: Thought?
    @Published var currentDespositedThought: Thought?
    @Published var currentFeedIndex: Int = 0
    
    // TODO: add router for navigation here.
    // TODO: add booleans for loading transitions (bonus)
    
    func createUser(email: String, password: String) {
        
    }
    
    func login(email: String, password: String) {
        
    }
    
    func popDepositedThought(thought: Thought) { }
    
    func createThought(text: String) { }
    
    func depositThought(thought: Thought) { }
    
    func goToNextThought() {}
    
    var description: String = "CentralViewModel"
    
}
