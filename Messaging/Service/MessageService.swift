//
//  MessageService.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 5/12/24.
//

import Foundation
import Firebase

struct MessageService {
    
    static let messagesCollection = Database.database().reference().child("messages")
    
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("Error: Current user ID is nil")
            return
        }
        
        guard let chatPartnerId = user.id as? String, !chatPartnerId.isEmpty else {
                print("Error: Chat partner ID is empty")
                return
            }
        
        print("Message service: Chatpartnerid = \(chatPartnerId)")
        
        let currentUserRef = messagesCollection.child(currentUid).child(chatPartnerId).childByAutoId()
        let chatPartnerRef = messagesCollection.child(chatPartnerId).child(currentUid).childByAutoId()
        
        
        let recentCurrentUserRef = messagesCollection.child(currentUid).child("recent-messages").child(chatPartnerId)
        let recentPartnerRef = messagesCollection.child(chatPartnerId).child("recent-messages").child(currentUid)
        
        
        let messageId = currentUserRef.key ?? UUID().uuidString
        
        let message = Message(messageId: messageId, fromId: currentUid, toId: chatPartnerId, messageText: messageText)
        
        
        let messageDictionary: [String: Any] = [
            "messageId": message.messageId ?? "",
            "fromId": message.fromId,
            "toId": message.toId,
            "messageText": message.messageText,
            "timestamp": message.timestamp
             
        ]
        
        
        currentUserRef.setValue(messageDictionary) { error, _ in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            } else {
                print("Message sent successfully")
            }
        }
        
        
        chatPartnerRef.setValue(messageDictionary) { error, _ in
            if let error = error {
                print("Error sending message to chat partner: \(error.localizedDescription)")
            } else {
                print("Message sent successfully to chat partner")
            }
        }
        recentCurrentUserRef.setValue(messageDictionary) { error, _ in
                if let error = error {
                    print("Error updating recent message for current user: \(error.localizedDescription)")
                } else {
                    print("Recent message updated successfully for current user")
                }
            }
            
            recentPartnerRef.setValue(messageDictionary) { error, _ in
                if let error = error {
                    print("Error updating recent message for chat partner: \(error.localizedDescription)")
                } else {
                    print("Recent message updated successfully for chat partner")
                }
            }
    }
    
    static func observeMessages(chatPartner: User, completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let ref = Database.database().reference().child("messages").child(currentUid).child(chatPartnerId)
        
        ref.queryOrdered(byChild: "timestamp").observe(.childAdded) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            let fromId = value["fromId"] as? String ?? ""
            let toId = value["toId"] as? String ?? ""
            let text = value["messageText"] as? String ?? ""
            let timestamp = value["timestamp"] as? Int ?? Int(Date().timeIntervalSince1970 * 1000)
            let messageId = value["messageId"] as? String
            
            
            
            var message = Message(
                messageId: messageId,
                fromId: fromId,
                toId: toId,
                messageText: text,
                timestamp: timestamp,
                user: fromId != currentUid ? chatPartner : nil
            )
            print("Message: \(message.messageText) ")
            
            completion([message])
        }
    }

}




