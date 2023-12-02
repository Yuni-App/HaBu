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
    var filteredUsers: [User] {
        if isSearchBar {
            return User.MockData.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.username.localizedCaseInsensitiveContains(searchText)
            }
        } else {
            let sortedUsers = User.MockData.filter { $0.rating > 0 }.sorted { $0.rating > $1.rating }
            return Array(sortedUsers.prefix(3))
        }
    }
    var filteredUsers2: [User] {
        let sortedUsers2 = User.MockData.filter { $0.rating > 0 }.sorted { $0.rating > $1.rating }
        let startIndex = 3
        let endIndex = min(sortedUsers2.count, 10)
        return Array(sortedUsers2[startIndex..<endIndex])
    }
    var body: some View {
        NavigationStack {
            SearchBar(searchText: $searchText, isEditing: $isSearchBar)
                .padding(.top, 8)
            ScrollView {
                VStack {
                    LazyVStack(spacing: 15) {
                        ForEach(filteredUsers, id: \.id) { user in
                            SearchItem(user: user, ratingSorted: ratingSorted)
                        }
                        .padding(.top,15)
                    }
                    ScrollView(.horizontal, showsIndicators: false){
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
            }
        }
    }
}
struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Ara...", text: $searchText)
                    .padding(8)
                    .padding(.horizontal, 24)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onTapGesture {
                        isEditing = true
                    }
                if isEditing {
                    Button(action: {
                        searchText = ""
                        isEditing = false
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SerachView()
}
