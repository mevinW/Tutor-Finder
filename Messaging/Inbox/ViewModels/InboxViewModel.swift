//
//  InboxViewModel.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 5/1/24.
//

import SwiftUI
import Combine
import Firebase



class InboxViewModel: ObservableObject{
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers(){
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = [Message]()
        let group = DispatchGroup()
        
        for change in changes {
            group.enter()
            guard let dictionary = change.snapshot.value as? [String: Any] else {
                print("IVM: Failed to convert snapshot to dictionary")
                group.leave()
                continue
            }
            
            print("IVM: Dictionary from snapshot: \(dictionary)")
            
            do {
                guard let fromId = dictionary["fromId"] as? String,
                      let toId = dictionary["toId"] as? String,
                      let messageText = dictionary["messageText"] as? String,
                      let timestamp = dictionary["timestamp"] as? Int else {
                    throw NSError(domain: "", code: -1, userInfo: nil)
                }
                
                let message = Message(
                    messageId: dictionary["messageId"] as? String,
                    fromId: fromId,
                    toId: toId,
                    messageText: messageText,
                    timestamp: timestamp
                )
                
                print("IVM: Created message: \(message)")
                
                UserService.fetchUser(withUid: message.chatPartnerId) { user in
                    var messageWithUser = message
                    messageWithUser.user = user
                    messages.append(messageWithUser)
                    print("IVM: Appended message with user: \(messageWithUser)")
                    group.leave()
                }
            } catch {
                print("Error initializing message: \(error)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.recentMessages.removeAll()
            
            // Append only unique messages
            for message in messages {
                if !self.recentMessages.contains(where: { $0.toId == message.toId }) {
                    self.recentMessages.append(message)
                }
            }
            
            print("IVM: Final recent messages: \(self.recentMessages)")
        }
    }
}
