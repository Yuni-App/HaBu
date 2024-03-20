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
            NavigationLink(destination: ProfileView(user: user), label: {
                HStack {
                    CircleProfileImage(userIamgeUrl: user.profileImageUrl?.first ?? "", size: .xsmall)
                    VStack {
                        HStack {
                            Text("\(user.name) \(user.surname)").fontWeight(.semibold).foregroundStyle(Color.black)
                            Spacer()
                        }
                        HStack {
                            Text("\(user.department)").font(.footnote).fontWeight(.semibold).foregroundStyle(Color(UIColor(hex: "c4c4c4")))
                            Spacer()
                        }
                    }
                }.padding()
                    .frame(width: Const.width * 0.9, height: Const.height * 0.07).background(Color(UIColor(hex: "777777"))).cornerRadius(10)
            }
            )
        }
     
    }
}
