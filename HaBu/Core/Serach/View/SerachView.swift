//
//  SerachView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI


struct SerachView: View {
    @State private var searchText = ""
    @State private var ratingSorted = false
    @State private var isEditing = false
    @State private var isSecondSearchViewActive: Bool = false

    var filteredUsers1: [User] {
        let sortedUser = User.MockData.filter { $0.rating > 0 }.sorted { $0.rating > $1.rating }
        return Array(sortedUser.prefix(3))
    }

    var filteredUsers2: [User] {
        let sortedUsers2 = User.MockData.filter { $0.rating > 0 }.sorted { $0.rating > $1.rating }
        return Array(sortedUsers2.dropFirst(3).prefix(7))
    }

    var body: some View {
            VStack {
                HStack {
                    SearchBar(searchText: $searchText, isEditing: $isEditing, isSecondSearchViewActive: $isSecondSearchViewActive)
                }.frame(width: Const.width * 0.97)
                Spacer()
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
                        }.padding(.top, 17)
                    }
                
            }.frame(width: Const.width).background(Const.primaryBackGroundColor)
        }
    }
}


#Preview {
    SerachView()
}
