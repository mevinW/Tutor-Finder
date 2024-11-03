//
//  Final_ProjectApp.swift
//  Final Project
//
//  Created by Kevin Wu (student LM) on 3/8/24.
//

import SwiftUI
import Firebase






@main
struct Final_ProjectApp: App {
    
    
    init(){
        FirebaseApp.configure()
    }
    
    @StateObject var user: User = User()
    @StateObject var tutors: Tutors = Tutors()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
            
        }
    }
}
