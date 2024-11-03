//
//  LoginView.swift
//  Final Project
//
//  Created by Matthew Roper (student LM) on 4/1/24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var user:User
    
    
    @StateObject var viewModel = loginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.mint
                
                VStack{
                    
                    RoundedRectangle(cornerRadius: 30,style: .continuous)
                        .foregroundStyle(.linearGradient(colors: [.mint,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 2000,height: 550)
                        .rotationEffect(.degrees(135))
                        .offset(y: -350)
                    
                    RoundedRectangle(cornerRadius: 30,style: .continuous)
                        .foregroundStyle(.linearGradient(colors: [.mint,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 2000,height: 550)
                        .rotationEffect(.degrees(135))
                        .offset(y: 350)
                }
                VStack(spacing: 20){
                        Text("Welcome")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(.all)
                            .bold()
                        TextField("Email Address", text: $viewModel.email)
                        .padding(.all,13)
                        .foregroundColor(.black)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding(.all,13)
                            .privacySensitive()
                            .foregroundColor(.black)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled(true)
                        
                        Button {
                            Task{ try await viewModel.login()}
                        } label: {
                            Text("Login    ")
                                .foregroundColor(.white)
                                .background(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(20)
                                .font(.largeTitle)
                        }.padding(.bottom,45)
                    
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                        .italic()
                        .font(.title2)
                    
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Sign Up")
                        
                    }

                }.frame(width: 350)
            }.ignoresSafeArea()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(User())
    }
}
