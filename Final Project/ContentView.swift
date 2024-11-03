//
//  ContentView.swift
//  Final Project
//
//  Created by Kevin Wu (student LM) on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        
            Group{
                if viewModel.userSession != nil{
                    InboxView()
                } else{
                    WelcomeView()
                }
            }
        
        }

    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
