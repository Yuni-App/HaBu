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
                                CircleProfileImage(userIamgeUrl: "", size: .small).frame(width: Const.width * 0.15)
                                VStack (alignment:.leading){
                                    Text("\(user.name) \(user.surName)")
                                        .opacity(0.85)
                                        .font(.title3)
                                    Text(user.username).opacity(0.6).font(.footnote)
                                    
                                }
                                Spacer()
                                
                                HStack {
                                    switch (ratingSorted, user.rating) {
                                    case (false, 20...30):
                                        Image(systemName:"star.fill")
                                            .foregroundColor(Color(UIColor(hex: "#CD7F32")))
                                    case(false, 30...40):
                                        Image(systemName:"star.fill")
                                            .foregroundColor(Color(UIColor(hex: "#808080")))
                                    case (false, 40...50):
                                        
                                        Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                                        )
                                        
                                    case (false, 50...65):
                                        Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                                        )
                                        Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                                        )
                                    case (false, 65...100):
                                        Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                                        )
                                        Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                                        )
                                        Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                                        )
                                        
                                        
                                    default:
                                        Image(systemName: "star")
                                            .foregroundColor(Color.gray)
                                    }
                                }.frame(width: Const.width * 0.2)
                                
                            }
                            .frame(width: Const.width * 0.9, height:Const.height * 0.08, alignment: .leading)
                            
                            .background(Color(UIColor(hex: "#FFFBF1"))).cornerRadius(10)
                            .shadow(color: .black.opacity(0.25), radius: 10)
                            .foregroundStyle(.black)
                            .padding(.leading,3)
                        })
                    }
                }
                .padding(.top,15)
                .searchable(text: $searchText,prompt: "Arama...").onChange(of: searchText) { oldValue, newValue in
                    isSearchBar = newValue != ""
                }
            }
            .navigationTitle("Arama")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SerachView()
}
