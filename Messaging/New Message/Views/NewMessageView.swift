//
//  NewMessageView.swift
//  Final Project
//
//  Created by Beckett Field (student LM) on 4/10/24.
//

import SwiftUI
import Firebase
let emptyUser = User(name: "jerry", grade: "", subject: "", email: "", password: "")

struct NewMessageView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        NavigationStack {
            ScrollView{
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTACTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.users) { user in
                    VStack {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color(.systemGray4))

                            Text(user.name )
                                .font(.subheadline)
                                .fontWeight(.semibold)
                               
                            Spacer()
                        }
                        .padding(.leading)

                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                        print(user.uid)
                    }
                }
           
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.black )
                }
            }
            
        }
    }
}


struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NewMessageView(selectedUser: .constant(emptyUser))
        }
    }
}
