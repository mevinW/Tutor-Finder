//
//  NewMessageViewModel.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 5/1/24.
//

import SwiftUI
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            do {
                try await fetchUsers()
                print("Debug: \(users.first?.grade)")
            } catch {
                print("Error fetching users: \(error)")
            }
        }
    }

    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        self.users = try await UserService.shared.fetchUsers()
        print("Debug: \(users.first?.grade)")
    }
    

}
