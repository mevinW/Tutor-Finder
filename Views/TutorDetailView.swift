//
//  TutorDetailView.swift
//  Final Project
//
//  Created by Kevin Wu (student LM) on 3/19/24.
//

import SwiftUI

struct TutorDetailView: View {
    var user: User
    
    var body: some View{
        VStack{
            Text(user.name)
                .font(.custom("Helvetica Neue Thin", size: 30))
          //  Text(user.grade)
                .font(.custom("Helvetica Neue Thin", size: 30))
            Text(user.subject)
                .font(.custom("Helvetica Neue Thin", size: 30))
        }
    }
}

struct TutorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TutorDetailView(user: User())
    }
}
