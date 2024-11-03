//
//  TutorProfile.swift
//  Final Project
//
//  Created by Kevin Wu (student LM) on 3/15/24.
//

import SwiftUI

import Foundation

class User: ObservableObject, Identifiable, Hashable, Codable {
    
    @Published var name: String
    @Published var email: String
    @Published var password: String
    @Published var grade: String
    @Published var subject: String
    @Published var isTutor: Bool
    @Published var uid: String
    
    init(name: String = "", grade: String = "9", subject: String = "", email: String = "", password: String = "", isTutor: Bool = false, uid: String = "") {
        self.name = name
        self.grade = grade
        self.subject = subject
        self.email = email
        self.password = password
        self.isTutor = isTutor
        self.uid = uid
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case name, email, password, grade, subject, isTutor, uid
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        grade = try container.decode(String.self, forKey: .grade)
        subject = try container.decode(String.self, forKey: .subject)
        isTutor = try container.decode(Bool.self, forKey: .isTutor)
        uid = try container.decode(String.self, forKey: .uid)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(grade, forKey: .grade)
        try container.encode(subject, forKey: .subject)
        try container.encode(isTutor, forKey: .isTutor)
        try container.encode(uid, forKey: .uid)
    }
}

