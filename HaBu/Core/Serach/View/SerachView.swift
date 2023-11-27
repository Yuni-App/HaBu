//
//  SerachView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct SerachView: View {
    @State private var searchText = ""
    @State private var isSearchBar = false
    @State private var ratingSorted = false
    
    //filtered user "name" or "userName"
    var filteredUser: [User]{
        if isSearchBar{
            return User.MockData.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.username.localizedCaseInsensitiveContains(searchText)
            }
        }else {
            return User.MockData.filter { $0.rating > 20 }.sorted { $0.rating > $1.rating }
        }
    }
    
    var ratingSort: [User]{
        if ratingSorted{
            return User.MockData.filter {
                $0.rating >= 20 && $0.rating <= 30
            }
        }else{
            return User.MockData.filter {
                $0.rating > 40
            }
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
                                Spacer()
                                
                                HStack {
                                    switch (ratingSorted, user.rating) {
                                    case (false, 20...30):
                                        Image(systemName:"star.fill").background(Color.white)
                                            .foregroundColor(Color.cyan)
                                    case(false, 30...40):
                                        Image(systemName:"star.fill").background(Color.white)
                                            .foregroundColor(Color.yellow)
                                    case (false, 40...):
                                        Image(systemName: "star.fill").background(Color.white).foregroundStyle(Color.yellow)
                                        Image(systemName: "star.fill").background(Color.white).foregroundStyle(Color.yellow)
                                    default:
                                        Image(systemName: "star")
                                                    .foregroundColor(Color.gray)
                                    }                                }
                                
                            }
                            .frame(width: Const.width * 0.9,alignment: .leading)
                            .foregroundStyle(.black)
                            .padding(.leading,8)
                        })
                    }
                }
                .padding(.top,15)
              /*  .searchable(text: $searchText,prompt: "Arama...").onChange(of: searchText) { oldValue, newValue in
                    isSearchBar = newValue != ""
                }*/
            }
            .navigationTitle("Arama")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SerachView()
}
