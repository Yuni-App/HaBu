//
//  newSearchView.swift
//  HaBu
//
//  Created by mert alp on 18.03.2024.
//

import SwiftUI

struct ProfileSearchView: View {
    @StateObject var usersLookup = UsersLookupViewModel()
    @State var keyword = ""
    
    var body: some View {
        let keywordBinding = Binding<String>(
            get: {
                keyword
            },
            set: {
                print("set")
                keyword = $0
                usersLookup.fetchUsers(with: keyword)
            }
        )
        VStack {
          
            SearchBarView(keyword: keywordBinding)
            ScrollView {
             
                ForEach(usersLookup.queryResultUsers, id: \.id) { user in
                    ProfileBarView(user: user)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SearchBarView: View {
    @Binding var keyword: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.5))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Arama...", text: $keyword)
                .autocapitalization(.none)
            }
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

struct ProfileBarView: View {
    var user: User
    
    var body: some View {
        ZStack {
            Rectangle()
            .foregroundColor(Color.gray.opacity(0.2))
            HStack {
                Text("\(user.username)")
                Spacer()
                Text("\(user.name) \(user.surname)")
            }
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .cornerRadius(13)
        .padding()
    }
}
