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
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    SearchBar(searchText: $searchText, isEditing: $isSearchBar)
                                            .padding(.top, 8)
                    LazyVStack(spacing: 15) {
                        ForEach(filteredUsers, id: \.id) { user in
                            SearchItem(user: user, ratingSorted: ratingSorted)
                        }
                        .padding(.top,15)
                        
                        }
                        .navigationTitle("Arama")
                    .navigationBarTitleDisplayMode(.inline)
                }
                }
            }
        }
    }
struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool

    var body: some View {
        HStack {
            TextField("Ara", text: $searchText)
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




#Preview {
    SerachView()
}
