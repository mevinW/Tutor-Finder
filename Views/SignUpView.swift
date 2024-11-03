//
//  SignUpView.swift
//  Final Project
//
//  Created by Matthew Roper (student LM) on 4/1/24.
//

import SwiftUI
import Firebase


struct SignUpView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.mint.opacity(0.6)
            
            VStack{
                Text("SignUp").foregroundColor(.white).font(.largeTitle).bold().padding([.top,],80)
                    Text("already have an acount?").foregroundColor(.blue)
                    .font(.title3)
                    .padding(.top,10)
                    Button {
                        dismiss()
                    } label: {
                        Text("Login   ")
                        
                    }.background(Rectangle().foregroundColor(.black).cornerRadius(5))
                    .foregroundColor(.white)
                        .font(.title3)
                        .padding(.top,5)
                        .padding(.bottom,20)
                        
                Divider()
               
                ScrollView{
                    VStack(alignment: .leading, spacing:20){
                        
                        TextField("Email Address", text: $viewModel.email)
                            .padding(.all)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled(true)
                        
                        
                        TextField("Name", text: $viewModel.name)
                            .padding(.all)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled(true)
                        
                        if viewModel.password.count < 6{
                            
                            
                            Text("Please use at least six characters").padding([.leading,.top]).foregroundColor(.black)
                        }
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding([.leading,.trailing])
                            .privacySensitive()
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled(true)

                        
                        Picker("grade",selection: $user.grade){
                            Text("Grade 09").tag(9)
                            Text("Grade 10").tag(10)
                            Text("Grade 11").tag(11)
                            Text("Grade 12").tag(12)
                        }.pickerStyle(.automatic)
                            .background(Rectangle().foregroundColor(.white).cornerRadius(20))
                            .padding(.all)
                        
                        
                        Picker("Tutor or Student", selection: $viewModel.isTutor){
                            Text("Student").tag(false)
                            Text("Tutor").tag(true)
                        }.pickerStyle(.segmented).padding([.leading,.trailing], 50)
                        
                        
                        Text("Subjects you are interested in").font(.title3).padding(.all).foregroundColor(.white)
                        HStack {
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Math")
                                    .padding()
                                    .bold()
                                    .foregroundColor(.white)
                            }.background(Rectangle().foregroundColor(.black).cornerRadius(5).opacity(0.6))
                                .padding(.trailing,50)
                            Button {
                                
                            } label: {
                                Text("Physics").padding()
                                    .bold()
                                    .foregroundColor(.white)
                            }.background(Rectangle().foregroundColor(.black.opacity(0.6)).cornerRadius(5))
                            Spacer()
                        }.padding(.bottom,50)
                        
                        
                        
                        
                        HStack{
                            Spacer()
                            Button {
                                Task{ try await viewModel.createUser()}
                                user.uid = viewModel.uid
                            }label: {
                                Text("SignUp    ")
                                    .foregroundColor(.white).bold()
                                    .background(.black)
                                    .cornerRadius(10)
                                    .font(.largeTitle)
                            }
                            Spacer()
                        }.padding(.bottom,25)
                        
                    }
                }.padding([.top,.bottom],20)
               
               
                }
            }.edgesIgnoringSafeArea(.all)
    }
            
    }
    


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(User())
    }
}
