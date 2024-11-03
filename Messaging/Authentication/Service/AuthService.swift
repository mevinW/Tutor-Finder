//
//  AuthService.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/17/24.
//

import SwiftUI
import Firebase
import FirebaseDatabase


class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init(){
        self.userSession = Auth.auth().currentUser
        loadCurrentUserData()
        print("DEBUG: \(userSession?.uid)")
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, isTutor: Bool, name: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, name: name, id: result.user.uid)
            loadCurrentUserData()
            
        } catch{
            print("Failed to create user")
        }
    }
    
    
    func signOut(){
        do {
            try  Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch{
            print("\(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(email: String, name: String, id: String) async throws{
        let user = User(name: name, email: email)
        let database = Database.database()
        let ref = database.reference()

        // Reference to the "users" node with the document ID
        let usersRef = ref.child("users").child(id)

        // Set the value directly
        usersRef.setValue([
            "name": user.name,
            "email": user.email,
            "password": user.password,
            "grade": user.grade,
            "subject": user.subject,
            "isTutor": user.isTutor
        ]) { (error, _) in
            if let error = error {
                print("Error setting data: \(error)")
            } else {
                print("Data set successfully")
            }
        }
    }
    
    private func loadCurrentUserData(){
        Task{ try await UserService.shared.fetchCurrentUser() }
    }
    
}
