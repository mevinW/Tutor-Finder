//
//  InboxRowView.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/9/24.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack (alignment: .top, spacing: 12 ){
             Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color(.systemGray4))
            
            VStack(alignment: .leading, spacing: 4){
                Text("Heath Ledger")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Some text message for now that spands more than one line")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                
            }
            HStack{
                Text("Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
     }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView()
    }
}
