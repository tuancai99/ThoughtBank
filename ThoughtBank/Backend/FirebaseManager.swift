//
//  FirebaseManager.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  Static class which serves as an abstraction layer for Firebase API calls.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager {
    
    // TODO: add init(), variables, and functions.
    
    static var manager = FirebaseManager()
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    
    /**
        - important: Use this function in the CentralViewModel to create a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
    */

    func createUser(email: String, password: String) async {
    }
    
    /**
        - important: Use this function in the CentralViewModel to fetch any specified collection of data.
        - parameters:
            - collection: the type of collection from which we want to derive our data.
            - filter: a closure/callback
        - returns:
            - An array of either "Thought" or "User", depending on the collection specified.
    */

    func fetch(collection: Collection, filterID: (String) -> Bool) async throws -> [QueryItem] {
        return []
    }
    
    /**
        - important: Use this function in the CentralViewModel to add any given data to a specified collection.
        - parameters:
            - collection: the type of collection to which we want to add our data.
            - data: the item we want to add to our collection, either a newly created "User", or "Thought".
    */

    func add(collection: Collection, data: Codable) async throws {
    }
    
    
    
    
}


enum Collection: String {
    case thoughts = "thoughts", users = "users"
    
}

protocol QueryItem {
    var documentID: String { get set }
}
