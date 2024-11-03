//
//  LoginViewModel.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/17/24.
//

import SwiftUI

class loginViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws{
        try await AuthService().login(withEmail: email, password: password)
    }
}
