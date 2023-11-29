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

struct Thought: Identifiable, Codable, QueryItem, Hashable {
    var id: String {
        documentID
    }
    
    var documentID: String
    
    var content: String
    var userID: String
    var timestamp: Date
    var alias: String?
    
    // TODO: add init(), variables, functions, and decoder/encoder.
    
    func getTimeSinceUpload() -> String {
        return "0D, 0M, 0Y ago."
    }
    
    static let testingThoughts: [Thought] = [
        Thought(documentID: "a", content: "The quick brown fox jumps over the lazy dog.", userID: "eee444", timestamp: Date()),
        Thought(documentID: "b", content: "This is a second thought.", userID: "ghi789", timestamp: Date()),
        Thought(documentID: "i", content: "The existing user has already seen this thought. It should not be visible in the feed.", userID: "pqr567", timestamp: Date()),
        Thought(documentID: "c", content: "This is a very long thought. Think about how the UI should handle thoughts like these. Should it be scrollable? Should it be truncated? Should it be in another view? These are important design decisions that you need to make while developing an app that recieves user input which can be erratic and unexpected. But anyways, hope this extremely long thought doesn't mess things up.", userID: "abcdefghijklmnopqrstuvwxyz1234567890", timestamp: Date()),
        Thought(documentID: "d", content: "This is a much smaller thought in comparison.", userID: "jkl012", timestamp: Date()),
        Thought(documentID: "e", content: "This 👇 thought 💭 has ☺️ special ✨ characters 😍. \tIt also has unusual line\n\nbreaks\nthat\nmight\nmake\nthings\nlook\na\nbit\nweird.", userID: "mno234", timestamp: Date())
    ]
}
