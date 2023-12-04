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
    @State private var isSecondSearchViewActive: Bool = false
    
    //filtered user
    //vertical
    var filteredUsers1: [User]{
        let sortedUser = User.MockData.filter { $0.rating > 0}.sorted {$0.rating > $1.rating}
        return Array(sortedUser.prefix(3))
        // first three User
    }
    //horizontal
    var filteredUsers2: [User] {
        let sortedUsers2 = User.MockData.filter { $0.rating > 0 }.sorted { $0.rating > $1.rating }
        return Array(sortedUsers2.dropFirst(3).prefix(7))
        //start 4. USER to 10
    }
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("Search").resizable().frame(width: Const.width * 0.06, height: Const.height * 0.03)
                    SearchBar(searchText: .constant(""), isEditing: .constant(false), isSecondSearchViewActive: $isSecondSearchViewActive)
                        .padding(.top, 1)
                }.frame(width: Const.width * 0.9)
                
                
                if !isSecondSearchViewActive{
                    ScrollView {
                        VStack {
                            ForEach(filteredUsers1, id: \.id) { user in
                                SearchItem(user: user, ratingSorted: ratingSorted)
                            }
                            .padding(.top,15)
                            
                            ScrollView(.horizontal){
                                HStack{
                                    Spacer()
                                    ForEach(filteredUsers2, id: \.id) { user in
                                        SearchItem2(user: user, ratingSorted: ratingSorted)
                                    }
                                    .padding(.top,15)
                                    Spacer()
                                }.frame(height: Const.height * 0.25)
                            }
                        }
                    }                }
                
            }.background(
                NavigationLink(destination: SecondSearchView(), isActive: $isSecondSearchViewActive) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}


#Preview {
    SerachView()
}
