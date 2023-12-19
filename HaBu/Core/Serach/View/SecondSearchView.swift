//
//  SecondSearchView.swift
//  HaBu
//
//  Created by yusuf on 2.12.2023.
//

import SwiftUI

struct SecondSearchView: View {
    @State private var searchText = ""
    @State private var isSearchBar = false
    @State private var isSecondSearchViewActive: Bool = true
    //SearchFilter name , surname and username
    var users: [User]{
        if isSearchBar{
            return User.MockData.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.surName.localizedCaseInsensitiveContains(searchText) ||
                $0.username.localizedCaseInsensitiveContains(searchText)
            }
        }else {
            return []
        }
    }
    var body: some View {

        VStack{
                Spacer()
                HStack{
                    SearchBar(searchText: $searchText, isEditing: $isSearchBar, isSecondSearchViewActive: $isSecondSearchViewActive)
                        .frame(width: Const.width * 0.85)
                }
                ScrollView {
                    ForEach(users) { user in
                        SearchItem3(user: user)
                    }.transition(.opacity)
                    
                }.frame(width: Const.width * 0.9, height: Const.height * 0.85)
                    .padding()
                    .opacity(users.isEmpty ? 0 : 1) // Hide if there are no results
                    .animation(.easeInOut)
                    .navigationBarBackButtonHidden()
            }.frame(width: Const.width, height: Const.height).background(Const.primaryBackGroundColor)
        
    }
    
}


#Preview {
    SecondSearchView()
}
