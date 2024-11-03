//
//  InboxService.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 5/18/24.
//

import Foundation
import Firebase

enum DatabaseChangeType {
    case added
    case modified
    case removed
}

struct DocumentChange {
    let type: DatabaseChangeType
    let snapshot: DataSnapshot
}

class InboxService: ObservableObject {
    @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = Database.database().reference()
            .child("messages")
            .child(uid)
            .child("recent-messages")
            .queryOrdered(byChild: "timestamp")
        
        // Listen for new messages
        query.observe(.childAdded) { snapshot in
            let change = DocumentChange(type: .added, snapshot: snapshot)
            self.documentChanges.append(change)
            self.printDebugInfo()
        }
        
        // Listen for modified messages
        query.observe(.childChanged) { snapshot in
            let change = DocumentChange(type: .modified, snapshot: snapshot)
            self.documentChanges.append(change)
            self.printDebugInfo()
        }
    }
    
    private func printDebugInfo() {
        // Ensure we print the latest document changes
        print("InboxService: Document changes count: \(documentChanges.count)")
        if let firstChange = documentChanges.first {
            print("InboxService: First document change type: \(firstChange.type)")
            print("InboxService: First document snapshot value: \(firstChange.snapshot.value ?? "nil")")
        } else {
            print("InboxService: No document changes available.")
        }
    }
}


