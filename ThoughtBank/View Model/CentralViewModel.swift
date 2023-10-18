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

class CentralViewModel: ObservableObject, ViewModelProtocol {
    
    @Published var user: User = .init()
    @Published var feedThoughts: [Thought] = []
    
    func rejectThought(thought: Thought) {}
    
    func depositThought(thought: Thought) {}
    
    var description: String = "CentralViewModel"
    
}
