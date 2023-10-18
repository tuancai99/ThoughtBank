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
    
    @Published var user: User = .init()
    @Published var feedThoughts: [Thought] = []
    
    func rejectThought(thought: Thought) {}
    
    func depositThought(thought: Thought) {}
    
    var description: String = "PreviewViewModel"
    
}
