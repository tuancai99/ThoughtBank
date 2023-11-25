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
    
    var userID: String? {
        auth.currentUser?.uid
    }
    
    var email: String? {
        auth.currentUser?.email
    }
    
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
        let uid = res.user.uid
        
        let user = User(
            alias: Alias.generateUniqueAlias(),
            userID: uid,
            email: email,
            ownedThoughts: [],
            depositedThoughts: [],
            viewedThoughts: []
        )
        
        do {
            try await addUser(user: user)
        } catch {
            // Deleting account because the user would have no existence in our database.
            try await deleteAccount()
            throw FirestoreErrorCode(.aborted)
            
        }
        
        return user
    }
    
    /**
     
        ASSIGNED TO [VAMSI]

        - important: Use this function in the CentralViewModel to login a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
        - returns: the "User" object given by Firebase with essentiall information such as email, the unique user ID, etc.
    */
    func login(email: String, password: String) async throws -> ThoughtBank.User {
        // Step 1: Authenticate with given parameters. Throw error if unsuccessful.
        // Step 2: Get user information from Firestore using provided result from authentication. Authentication result contains information such as email, documentID, etc.
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        
        try await auth.signIn(withEmail: email, password: password)
        
        do {
            // Will always be a user, hence the forced type cast:
            let user = try await fetchUser()
            
            return user
        } catch {
            
            // Unauthenticate user if we experience trouble retrieving data,
            signOut()
            
            throw FirestoreErrorCode(.cancelled)
            
            // TODO: redirect user to registration if previously registered but no database instance exists.
            
        }
        
                
    }
    
    /**
     
        ASSIGNED TO [VAMSI]

        - important: Use this function in the CentralViewModel to sign out a user using Firebase -  the CentralViewModel handles the rest.
        - parameters:
            - email: as entered by user
            - password: as entered by user
        - returns: the "User" object given by Firebase with essentiall information such as email, the unique user ID, etc.
    */
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            
            // Will almost never happen, unless no user has been initialized or a keychain error occurs.
            print("Sign out failed due to \(error.localizedDescription).")
        }
    }

    /**
     
        ASSIGNED TO [SOHAM]

        - important: A fetch used to receive user's data. Use this function in the CentralViewModel to fetch user data. Throws an error.
      
        - returns:
            - A User object
    */

    func fetchUser() async throws -> User {
        // Step 1: Await the fetch via Firebase. Make a fetch query that gets documents that match this filter.
        
        // Step 2: Map the data to objects using the fetched documents.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.

        // TODO: use TaskManager to receive all documents concurrently.
        
        guard let userID = userID else { throw FirebaseAuth.AuthErrorCode(.appNotAuthorized) }
                
        let doc = try await db.collection("users").document(userID).getDocument()
        
        let alias: String = doc["alias"] as! String
        
        // MARK: wrap the 3 tasks in a task group for concurrency.
        
        let ownedThoughtsID: [String] = doc["myThoughts"] as! [String]

        let depositedThoughtsID: [String] = doc["deposited"] as! [String]
    
        let viewedThoughtsID: [String] = doc["viewedThoughts"] as! [String]
        
        async let ownedThoughts: [Thought] = fetchThoughts(filterField: .uuid, filterGroup: Set(ownedThoughtsID))

        async let depositedThoughts: [Thought] = fetchThoughts(filterField: .uuid, filterGroup: Set(depositedThoughtsID))
        
        async let viewedThoughts: [Thought] = fetchThoughts(filterField: .uuid, filterGroup: Set(viewedThoughtsID))
        
        return await User(alias: alias, userID: "fjkrehjgkue", email: "aziiz", ownedThoughts: try ownedThoughts, depositedThoughts: try depositedThoughts, viewedThoughts: try viewedThoughts)

    }
    
    
    /**
     
        ASSIGNED TO [SOHAM]

        - important: A fetch used to receive an array of thought items. Use this function in the CentralViewModel to fetch data. Throws an error.
        - parameters:
            - filterField: the parameter we care about filtering
            - filterGroup: the group of items which we want our filterField to equal to
                    
        - returns:
            - An array of either "Thought".
    */
    func fetchThoughts(filterField: ThoughtFilter = .none, filterGroup: Set<String>, _ onCompletion: @escaping () -> Void = {}) async throws -> [Thought] {
        
        onCompletion()
        
        let query: Query =
            filterField == .none || filterField == .uuid ?
                db.collection("thoughts") :
                db.collection("thoughts").whereField(filterField.key, in: Array(filterGroup) )
        
        let docs: [QueryDocumentSnapshot] = 
            filterField == .uuid ?
                try await query.getDocuments().documents.filter({ filterGroup.contains($0.documentID) }) :
                try await query.getDocuments().documents

        let items: [Thought] = docs.map { doc in
            let data = doc.data()
            let id = doc.documentID
            let content: String = data["content"] as! String
            let userID: String = data["userID"] as! String
            
            let timeStamp: Timestamp = data["timestamp"] as! Timestamp
            let timestampDecoded: Date = timeStamp.dateValue()
                            
            return Thought(documentID: id, content: content, userID: userID, timestamp: timestampDecoded)
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

    func addThought(content: String, userID: String, timestamp: Date = .now) async throws -> Thought {
 
        // Step 1: Add the data, encoded, to the specified collection as a document. Firebase API throws an error if adding failed, should also cause function to throw.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        let ref: DocumentReference = try await db.collection("thoughts").addDocument(data:  [
            "userID": userID,
            "content": content,
            "timestamp": Timestamp(date: timestamp)
        ])
        
        let addedThought = Thought(documentID: ref.documentID, content: content, userID:userID, timestamp:timestamp)
        
        return addedThought
    }
    
    
    func addUser(user: User) async throws {
        // Step 1: Add the data, encoded, to the specified collection as a document. Firebase API throws an error if adding failed, should also cause function to throw.
        
        // This is a throwing function, all errors thrown by a the Firebase API function are also implicitly thrown by this function, the 'try' keyword is useful here.
        // HINT: This is an async function, to handle our Firebase server calls, could the 'await' keyword be useful.
        let ref : DocumentReference = db.collection("users").document(user.userID)
        
        try await ref.setData([
            "alias": user.alias,
            "myThoughts": user.ownedThoughts,
            "deposited": user.depositedThoughts,
            "viewedThoughts": user.viewedThoughts
        ])
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
        try await databaseRef.setData([
            "alias": alias,
            "myThoughts": ownedThoughts,
            "deposited": depositedThoughts,
            "viewedThoughts": viewedThoughts
        ])
    }
    
    func deleteAccount() async throws {
        
        if let user = auth.currentUser {
            try await user.delete()
        } else {
            print("Cannot delete non-existent or non-logged user.")
        }
    }
    
    
    
}


enum ThoughtFilter: String {
    case uuid, userID = "userID", content = "content", timestamp = "timestamp", none
    
    var key: String {
        return self.rawValue
    }
    
}

protocol QueryItem {
    var documentID: String { get set }
}
