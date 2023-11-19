//
//  SerachView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct SerachView: View {
    @State private var searchText = ""
    
    //filtered user "name" or "userName"
    var filteredUser: [User]{
        return User.MockData.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.username.localizedCaseInsensitiveContains(searchText)
            }
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing:15){
                    //User.MockData = filtereduser
                    ForEach(filteredUser, id : \.id){user in
                        NavigationLink(destination: Text("ProfileView"),
                                       label: {
                            HStack(){
                                CircleProfileImage(userIamgeUrl: "", size: .small)
                                VStack (alignment:.leading){
                                    Text(user.username).fontWeight(.semibold).opacity(0.85)
                                    Text("\(user.name) \(user.surName)")
                                        .opacity(0.6)
                                        .font(.footnote)
                                    
                                }
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundStyle(.black)
                            .padding(.leading,8)
                        })
                    }
                }
                .padding(.top,15)
                .searchable(text: $searchText,prompt: "Arama...")
            }
            .navigationTitle("Arama")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SerachView()
}
