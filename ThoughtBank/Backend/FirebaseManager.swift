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
    let auth = Auth.auth() // Statefully stores authentication status and user information.
    
    
    /**
     
        ASSIGNED TO [JORDAN]
     
        - important: Use this function in the CentralViewModel to create a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
        - returns: the "User" object we designed with emptied parameters.

    */

    func createUser(email: String, password: String) async throws -> ThoughtBank.User {
        // Step 1: Authenticate with given parameters. Throw error if unsuccessful.
        // Step 2: Get User information from Firestore using provided result object. Object contains information such as email, documentID.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        let res = try await auth.createUser(withEmail: email, password: password)
        let user = res.user
        
        if let email = user.email {
            return User(alias: Alias.generateUniqueAlias(), userID: user.uid, email: email, ownedThoughts: [], depositedThoughts: [], viewedThoughts: [])
        } else {
            throw AuthErrorCode(.appNotAuthorized)
        }

    }
    
    /**
     
        ASSIGNED TO [VAMSI]

        - important: Use this function in the CentralViewModel to login a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
        - returns: the "User" object given by Firebase with essentiall information such as email, the unique user ID, etc.
    */
    func login(email: String, password: String) async throws -> FirebaseAuth.User {
        // Step 1: Authenticate with given parameters. Throw error if unsuccessful.
        // Step 2: Get user information from Firestore using provided result from authentication. Authentication result contains information such as email, documentID, etc.
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        let res = try await auth.signIn(withEmail: email, password: password)
        
        let user = res.user
        
        return user
    }

    
    /**
     
        ASSIGNED TO [SOHAM]

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
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        var query: Query
        var items: [QueryItem] = []

        // TODO: use TaskManager to receive all documents concurrently
        
        switch collection {
        case .thoughts:
            query = db.collection("thoughts")
            
            var docs: QuerySnapshot = try await query.getDocuments()
            for doc in docs.documents{
                let data = doc.data()
                let id = doc.documentID
                let content: String = data["content"] as? String ?? "empty"
                let userID: String = data["userID"] as? String ?? "noID"
                let timeStamp: Date = data["timestamp"] as? Date ?? Date()
                    
                // TODO: receive timestamp as Timestamp datatype and convert to Date.
                
                items.append(Thought(documentID: id, content: content, userID: userID, timestamp: timeStamp))
            }
        case .users:
            let doc = try await db.collection("users").document(filterID!).getDocument()
            let alias: String = doc["alias"] as? String ?? "empty"
                let userID: String = doc["userID"] as? String ?? "noID"
                let email: String = doc["email"] as? String ?? "empty"
                var ownedThoughts: [Thought] = []
                let ownedThoughtsID: [String] = doc["myThoughts"] as? [String] ?? []
                for id in ownedThoughtsID {
                    let ref = try await db.collection("thoughts").document(id).getDocument()
                    let content: String = ref["content"] as? String ?? "empty"
                    let userID: String = ref["userID"] as? String ?? "noID"
                    let timeStamp: Date = ref["timestamp"] as? Date ?? Date()
                    
                    // TODO: receive timestamp as Timestamp datatype and convert to Date.

                    ownedThoughts.append(Thought(documentID: id, content: content, userID: userID, timestamp: timeStamp))
                }
                var depositedThoughts: [Thought] = []
                let depositedThoughtsID: [String] = doc["depositedThoughts"] as? [String] ?? []
                for id in depositedThoughtsID {
                    let ref = try await db.collection("thoughts").document(id).getDocument()
                    let content: String = ref["content"] as? String ?? "empty"
                    let userID: String = ref["userID"] as? String ?? "noID"
                    let timeStamp: Date = ref["timestamp"] as? Date ?? Date()
                    
                    // TODO: receive timestamp as Timestamp datatype and convert to Date.

                    depositedThoughts.append(Thought(documentID: id, content: content, userID: userID, timestamp: timeStamp))
                }
                var viewedThoughts: [Thought] = []
                let viewedThoughtsID: [String] = doc["viewedThoughts"] as? [String] ?? []
                for id in viewedThoughtsID {
                    let ref = try await db.collection("thoughts").document(id).getDocument()
                    let content: String = ref["content"] as? String ?? "empty"
                    let userID: String = ref["userID"] as? String ?? "noID"
                    let timeStamp: Date = ref["timestamp"] as? Date ?? Date()
                    
                    // TODO: receive timestamp as Timestamp datatype and convert to Date.

                    viewedThoughts.append(Thought(documentID: id, content: content, userID: userID, timestamp: timeStamp))
                }
           items.append(User(alias: alias, userID: userID, email: email, ownedThoughts: ownedThoughts, depositedThoughts: depositedThoughts, viewedThoughts: viewedThoughts))
        }
        return items

        
    }
    
    /**
        ASSIGNED TO [TUAN]

        - important: Use this function in the CentralViewModel to add any given data to a specified collection.
        - parameters:
            - collection: the type of collection to which we want to add our data.
            - data: the item we want to add to our collection, either a newly created "User", or "Thought".
    */

    func addThought(content: String, userID: String, timestamp: Date) async throws -> Thought? {
 
        // Step 1: Add the data, encoded, to the specified collection as a document. Firebase API throws an error if adding failed, should also cause function to throw.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        var ref: DocumentReference = try await db.collection("thoughts").addDocument(data:  ["userID": userID, "content": content,"timestamp": timestamp])
        let addedThought = Thought(documentID: ref.documentID, content: content, userID:userID, timestamp:timestamp)
        return addedThought
    }
    
    
    func addUser(alias: String, userID: String,email: String, ownedThoughts: [Thought], depositedThoughts: [Thought], viewedThoughts: [Thought]) async throws -> User? {
        // Step 1: Add the data, encoded, to the specified collection as a document. Firebase API throws an error if adding failed, should also cause function to throw.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        let ref : DocumentReference = db.collection("users").document(userID)
        try await ref.setData(["alias": alias, "myThoughts": ownedThoughts, "deposited": depositedThoughts, "viewedThoughts": viewedThoughts])
        let addedUser = User(alias: alias, userID: ref.documentID , email: email , ownedThoughts: ownedThoughts, depositedThoughts: depositedThoughts, viewedThoughts: viewedThoughts)
        return addedUser
    }
    
    
    func reviewModeration(userThought: String) async {
       // Static info
       // connect to OpenAI
       let apiKey = "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"
       // specify which API service to use which is completions
       let endpoint = "https://api.openai.com/v1/completions"
       // Ask GPT to review the user input
       let parameters: [String: Any] = [
           "model": "gpt-3.5-turbo-instruct",
            "prompt": "Does the user input '\(userThought)' violate community guidelines related to topics such as sex, suicide, hate speech, harassment, explicit or adult content, violence or gore, and inappropriate language? Please respond with a 'Yes' or 'No'. Your answer should consist of only one word.",
            "max_tokens": 7,
            "temperature": 0
        ]
       
//        URL is optional because there will be case it could be a wrong URL
       guard let url = URL(string: endpoint) else {
           print("Invalid URL!")
           return
       }
       
       
//        create a POST request with specified header
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
       
//        specify the request body
       do {
//            serialize body from NSDictionnary (foundation object) to JSON object
           request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
       } catch {
           print("Error occured: \(error)")
           return
       }
       
       do {
//            Actually make the request
           let (data, _) = try await URLSession.shared.data(for: request) //type: Data
           
//           Serialize data returned from the POST request to
           let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //type: Dictionary<String, Any>
           // Optional<Any>
           
//            guard let decision = json["choices"] else {
//                print("Empty response from OpenAI!")
//                return
//            } // type: __NSSingleObjectArrayI

           if let decisionArr = json["choices"] as? [[String:Any]],
              let decision = decisionArr.first {
               if let text = decision["text"] as? String {
                   let trimmedString = text.trimmingCharacters(in: .whitespacesAndNewlines)
                   switch trimmedString {
                   case "Yes":
                       print("Your message has been flagged for a potential violation of our community guidelines. Kindly take a moment to review our guidelines to ensure that your contributions align with our community standards. Thank you for your cooperation.")
                   case "No":
                       print("Your input aligns with our community guidelines. Thank you for adhering to our standards!")
                   default:
                       print("Try again!")
                   }
               } else {
                   print("Unable to retrieve the review!")
               }
           }
       } catch {
           print("Error occured: \(error)")
       }
       
   }
    /**
     
        ASSIGNED TO [ETHAN]

        - important: Use this function in the CentralViewModel to update a user's data on Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - user: the user corresponding to the ongoing session, and the one who's values we want to update on the cloud.
    */
    func updateUserData(user: User) async throws {
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        
        let alias = user.alias
        let ownedThoughts = user.ownedThoughts.map({ $0.documentID })
        let depositedThoughts = user.depositedThoughts.map({ $0.documentID })
        let viewedThoughts = user.viewedThoughts.map({ $0.documentID })
        let databaseRef = db.collection("users").document(user.documentID)
        try await databaseRef.setData(["alias": alias,
                                   "myThoughts": ownedThoughts,
                                   "deposited": depositedThoughts,
                                   "viewedThoughts": viewedThoughts])
    }
    
    
    
}


enum Collection: String {
    case thoughts = "thoughts", users = "users"
    
}

protocol QueryItem {
    var documentID: String { get set }
}
