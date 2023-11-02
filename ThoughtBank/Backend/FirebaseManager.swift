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

final class FirebaseManager {
        
    static var manager = FirebaseManager()
    
    let db = Firestore.firestore()
    let auth = Auth.auth() // Statefully stores authentication status and information
    
    
    /**
        - important: Use this function in the CentralViewModel to create a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
    */

    func createUser(email: String, password: String) async throws {
        // Step 1: Authenticate with given parameters. Throw error if unsuccessful.
        // Step 2: Get User information from Firestore using provided result object. Object contains information such as email, documentID.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
    }
    
    /**
        - important: Use this function in the CentralViewModel to login a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
    */
    func login(email: String, password: String) async throws {
        // Step 1: Authenticate with given parameters. Throw error if unsuccessful.
        // Step 2: Get user information from Firestore using provided result from authentication. Authentication result contains information such as email, documentID, etc.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
    }

    
    /**
        - important: A general purpose fetch used to receive an array query items. In the case of our app, we will always want the query to return a list of Thoughts, or an array of size 1 containing the user with the documentID at "filterID". Use this function in the CentralViewModel to fetch the specified collection of data.
        - parameters:
            - collection: the type of collection from which we want to derive our data.
            - filterID: the documentID specified to filter our query to one item.
        - returns:
            - An array of either "Thought" or "User", depending on the collection specified.
    */

    func fetch(collection: Collection, filterID: String?) async throws -> [QueryItem] {
        // Step 1: Await the fetch via Firebase. Make a fetch query that gets documents that match this filter.
        
        // Step 2: Map the data to objects using the fetched documents.
        return []
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
    }
    
    /**
        - important: Use this function in the CentralViewModel to add any given data to a specified collection.
        - parameters:
            - collection: the type of collection to which we want to add our data.
            - data: the item we want to add to our collection, either a newly created "User", or "Thought".
    */

    func add(collection: Collection, data: Codable) async throws {
        
        // Step 1: Add the data, encoded, to the specified collection as a document. Firebase API throws an error if adding failed, should also cause function to throw.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        
    }
    
    /**
        - important: Use this function in the CentralViewModel to update a user's data on Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - user: the user corresponding to the ongoing session, and the one who's values we want to update on the cloud.
    */
    func updateUserData(user: User) async throws {
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
    }
    
    
    
}


enum Collection: String {
    case thoughts = "thoughts", users = "users"
    
}

protocol QueryItem {
    var documentID: String { get set }
}
