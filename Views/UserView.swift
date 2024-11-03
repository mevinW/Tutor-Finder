//
//  User.swift
//  Final Project
//
//  Created by Kevin Wu (student LM) on 3/15/24.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var tutors: Tutors
    
    
    var body: some View {
        VStack {
            Text("\(user.name)")
                .font(.title)
                .padding(.bottom, 50)
            TextField("Name", text: $user.name)
                .foregroundColor(.gray)
                .padding(.leading, 50)
                .padding(.bottom, 25)
            Picker("grade",selection: $user.grade){
                Text("Grade 09").tag(9)
                Text("Grade 10").tag(10)
                Text("Grade 11").tag(11)
                Text("Grade 12").tag(12)
            }
                .foregroundColor(.gray)
                .padding(.leading, 50)
                .padding(.bottom, 25)
            TextField("Subject", text: $user.subject)
                .foregroundColor(.gray)
                .padding(.leading, 50)
                .padding(.bottom, 50)
            
            Button {
                tutors.tutorsList.append(User(name: user.name, grade: user.grade, subject: user.subject))
            } label: {
               Text("Add Profile")
            }
            
            Button {
                AuthService().signOut()
            } label: {
                Text("Sign Out")
            }.padding()

        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(User())
            .environmentObject(Tutors())
    }
}
