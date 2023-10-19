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
    
    var user: User? { get set }
    var feedThoughts: [Thought] { get set }
    var currentThought: Thought? { get set }
    
    func createUser(email: String, password: String)
    
    func login(email: String, password: String)
    
    func popDepositedThought(thought: Thought)
    
    func createThought(text: String)
    
    func depositThought(thought: Thought)
    
    func goToNextThought()
        
}
