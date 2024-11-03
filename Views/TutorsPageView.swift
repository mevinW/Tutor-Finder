//
//  TutorsPage.swift
//  Final Project
//
//  Created by Kevin Wu (student LM) on 3/15/24.
//

import SwiftUI

struct TutorsPageView: View {
    @EnvironmentObject var tutors: Tutors
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            NavigationView {
                List(tutors.tutorsList) { user in
                    NavigationLink(destination: {
                        TutorDetailView(user: user)
                    }, label: {
                        HStack {
                            Text(user.name)
                        }
                    })
                }
                .navigationTitle("Tutors")
            }
            .padding()
        }
    }
}

struct TutorsPageView_Previews: PreviewProvider {
    static var previews: some View {
        TutorsPageView()
            .environmentObject(User())
            .environmentObject(Tutors())
    }
}
