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
        VStack {
            NavigationStack {
                HStack{
                    CustomSearchBar(destinaiton: AnyView(SerachView()))
                    SearchBar(searchText: $searchText, isEditing: $isSearchBar, isSecondSearchViewActive: $isSecondSearchViewActive)
                        .frame(width: Const.width * 0.85)
                }
                ScrollView {
                    
                    ForEach(users) { user in
                        HStack {
                            CircleProfileImage(userIamgeUrl: "Mert", size: .xsmall)
                            VStack {
                                HStack {
                                    Text("\(user.name) \(user.surName)").fontWeight(.semibold)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(user.department)").font(.footnote).fontWeight(.semibold).foregroundStyle(Color(UIColor(hex: "777777")))
                                    Spacer()
                                }
                            }
                        }.padding()
                            .frame(width: Const.width * 0.9, height: Const.height * 0.07).background(Color(UIColor(hex: "F0F0F0"))).cornerRadius(3)
                    }
                    
                }
                .navigationBarBackButtonHidden()
            }
        }
        
    }
}

#Preview {
    SecondSearchView()
}
