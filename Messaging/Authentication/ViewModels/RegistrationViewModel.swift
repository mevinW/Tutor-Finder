//
//  RegistrationViewModel.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/17/24.
//

import SwiftUI

class RegistrationViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var isTutor = false
    @Published var name = ""
    @Published var uid = ""
    
    
    func createUser() async throws {
        try await AuthService().createUser(withEmail: email, password: password, isTutor: isTutor, name: name, uid: uid )
    }
}
