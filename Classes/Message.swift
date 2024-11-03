//
//  Message.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 5/12/24.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Message: Identifiable, Codable, Hashable{
    
    var messageId: String?
    
    let fromId: String
    let toId: String
    let messageText: String
    var timestamp = Int(Date().timeIntervalSince1970 * 1000)
    
    var user: User?
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    

}
