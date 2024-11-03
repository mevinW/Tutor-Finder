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
            self.currentUser = user
                           
        } withCancel: { error in
            print("Error fetching current user: \(error.localizedDescription)")
        }
    }
    
    
    
}
