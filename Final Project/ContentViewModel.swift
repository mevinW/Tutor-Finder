//
//  ContentViewModel.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 5/1/24.
//

import Firebase
import SwiftUI
import Combine

class ContentViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setUpSubscribers()
    }
    
    private func setUpSubscribers(){
        AuthService().$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
