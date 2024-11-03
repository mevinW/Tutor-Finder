//
//  InboxRowView.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/9/24.
//

import SwiftUI

struct InboxRowView: View {
    
    let message: Message
    var body: some View {
        HStack (alignment: .top, spacing: 12 ){
             Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color(.systemGray4))
            
            VStack(alignment: .leading, spacing: 4){
                Text(message.user?.name ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                
            }
            HStack{
                Text(formatDate(date: message.timestamp))
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
     }
    
    private func formatDate(date: Int) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
            return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date) / 1000))
        }
}

//struct InboxRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InboxRowView()
//    }
//}
