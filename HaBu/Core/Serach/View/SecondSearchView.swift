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
    @Environment(\.dismiss) private var dismiss
    @State private var isSecondSearchViewActive: Bool = true
   // @State private var users: [User] = [] // Store users fetched from Firebase
   // user mockdata yerine firebase ile yapacak
    
    //SearchFilter name , surname and username
    var users: [User]{
        if isSearchBar{
            return User.MockData.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.surname.localizedCaseInsensitiveContains(searchText) ||
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
                    Buttons.backButton{
                        dismiss()
                    }
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
    /*
     FİREBASE İÇİN EKLENECEK KODLAR
     ARAMA YAPMAYA BAŞLADIĞINDA FİREBASE ÜZERİNDE KULLANICI GETİRECEK,
     GETİRECEĞİ İSİMLER FİREBASE'DE userNames ile kayıtlı olan tabloya göre
     
    // Function to fetch users from Firebase
        func fetchUsers() {
            searchQueryUsers(text: searchText) { userNames in
                // (assuming you have a function to get user data by username)
                getUsersByUsernames(userNames) { fetchedUsers in
                    self.users = fetchedUsers
                }
            }
        }

        // Activate search mode
        func activateSearch() {
            isSearchBar = true
            fetchUsers() // Fetch users from Firebase when search starts
        }
    */
    
}


#Preview {
    SecondSearchView()
}

/*
 
 BOZUK
 struct SecondSearchView: View {
     @State private var searchText = ""
     @State private var isSearchBar = false

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
                 SearchBar(searchText: $searchText, isEditing: $isSearchBar, isSecondSearchViewActive: .constant(false))
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

 */
