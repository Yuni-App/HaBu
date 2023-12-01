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
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(filteredUser, id: \.id) { user in
                        SearchItem(user: user, ratingSorted: ratingSorted)
                    }
                }
                .padding(.top, 15)
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
