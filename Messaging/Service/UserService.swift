//
//  UserService.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/30/24.
//

import SwiftUI
import Firebase
import FirebaseDatabase

class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    
    @MainActor
    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let database = Database.database()
        let ref = database.reference()

        // Reference to the "users" node with the document ID
        let userRef = ref.child("users").child(uid)

        // Fetch the data
        userRef.observeSingleEvent(of: .value) { [weak self] (snapshot: DataSnapshot) in
            guard let self = self else { return }
            
            // Check if snapshot value is not nil
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                print("Error: Unable to retrieve user data from Firebase")
                return
            }
            
            let user = User(name: snapshotValue["name"] as? String ?? "",
                            grade: snapshotValue["grade"] as? String ?? "9", // Provide default string value
                            subject: snapshotValue["subject"] as? String ?? "",
                            email: snapshotValue["email"] as? String ?? "",
                            password: snapshotValue["password"] as? String ?? "")
            user.uid = uid
            self.currentUser = user
            //print("User service: \(currentUser?.uid)")
        } withCancel: { error in
            print("Error fetching current user: \(error.localizedDescription)")
        }
    }
    
    
    func fetchUsers() async throws -> [User] {
        var users = [User]()
        
        // Create a semaphore to synchronize the asynchronous operation
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let currentUid = Auth.auth().currentUser?.uid else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Current user is not authenticated"])
            }
            
        
        // Retrieve the snapshot asynchronously
        Database.database().reference().child("users").observeSingleEvent(of: .value) { snapshot in
            // Process the snapshot when it's available
            for case let childSnapshot as DataSnapshot in snapshot.children {
                if let userDict = childSnapshot.value as? [String: Any] {
                    let uid = userDict["uid"] as? String ?? ""
                    
                    if uid == currentUid {
                                        continue
                    }
                    
                    let name = userDict["Name"] as? String ?? ""
                    let grade = userDict["grade"] as? String ?? "9"
                    let subject = userDict["subject"] as? String ?? ""
                    let email = userDict["email"] as? String ?? ""
                    let password = userDict["password"] as? String ?? ""
                    
                    let user = User(name: name, grade: grade, subject: subject, email: email, password: password)
                    user.uid = uid
                    print(user.name, user.email)
                    users.append(user)
                }
            }
            
            print("Debug: \(users)")
            
            // Signal the semaphore to indicate completion
            semaphore.signal()
        } withCancel: { error in
            // Handle any errors that occur during the asynchronous operation
            print("Error fetching users: \(error.localizedDescription)")
            
            // Signal the semaphore to indicate completion
            semaphore.signal()
        }
        
        // Wait for the asynchronous operation to complete
        _ = semaphore.wait(timeout: .distantFuture)
        
        return users
    }

    static func fetchUser(withUid uid: String, completion: @escaping (User?) -> Void) {
            let ref = Database.database().reference().child("users").child(uid)
            
            ref.getData { error, snapshot in
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let snapshotValue = snapshot?.value as? [String: Any] else {
                    print("Error converting snapshot to dictionary for UID: \(uid)")
                    completion(nil)
                    return
                }
                
                // Manually creating a User instance
                let user = User()
                user.uid = uid
                user.name = snapshotValue["name"] as? String ?? ""
                user.email = snapshotValue["email"] as? String ?? ""
                // Set other properties as needed
                
                print("Fetched user: \(user.name)")
                completion(user)
            }
        }
}
