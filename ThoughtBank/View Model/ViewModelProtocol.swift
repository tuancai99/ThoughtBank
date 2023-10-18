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
    
    var user: User { get set }
    var feedThoughts: [Thought] { get set }
    
    func rejectThought(thought: Thought)
    
    func depositThought(thought: Thought)
    
}
