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
    @Environment(\.dismiss) private var dismiss
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
            HStack{
                Buttons.backButton{
                    dismiss()
                }
                SearchBarView(keyword: keywordBinding)
                
            }
            ScrollView {
                if usersLookup.queryResultUsers.isEmpty {
                    Text("Kullanıcı Bulunamadı")
                        .padding()
                } else {
                    ForEach(usersLookup.queryResultUsers, id: \.id) { user in
                        ProfileBarView(user: user)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SearchBarView: View {
    @Binding var keyword: String
    @State private var isSearchBar = false
    @State private var isSecondSearchViewActive: Bool = true
    var body: some View {
        ZStack {
            HStack {
                
                SearchBar(searchText: $keyword, isEditing: $isSearchBar, isSecondSearchViewActive: $isSecondSearchViewActive)
                    .frame(width: Const.width * 0.85)
                
                    .autocapitalization(.none)
            }
        }
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
                    .frame(width: Const.width * 0.9, height: Const.height * 0.07).background(Color(.systemGray6)).cornerRadius(10)
            }
            )
        }
        
    }
}
#Preview {
    ProfileSearchView()
}
