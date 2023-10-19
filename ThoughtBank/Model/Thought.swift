//
//  Thought.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  Thought object which can be encoded and decoded.
//
//  Views & view models should deal with thoughts using this struct and
//  *not* deal with JSON/dictionary data directly
//

import Foundation

struct Thought: Codable, QueryItem {
    var documentID: String
    
    var content: String
    var userID: String
    var timestamp: Date
    
    // TODO: add init(), variables, functions, and decoder/encoder.
    
    func getTimeSinceUpload() -> String {
        return "0D, 0M, 0Y ago."
    }
}
