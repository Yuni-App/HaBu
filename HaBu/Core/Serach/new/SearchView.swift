//
//  SearchView.swift
//  HaBu
//
//  Created by mert alp on 24.03.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var isSecondSearchViewActive: Bool = false
    @State private var isShowingSheet : Bool = false

    var body: some View {
        ZStack {
            Image("isletme")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity,height: .infinity)
                .overlay(
                    VStack {
                        HStack {
                            SearchBar(searchText: $searchText, isEditing: $isEditing, isSecondSearchViewActive: $isSecondSearchViewActive)
                                .padding()
                            Spacer()
                           
                        }
                        Spacer()
                        Text("Daha Fazla Bilgi").foregroundColor(.gray)
                                                   .onTapGesture {
                                                       isShowingSheet = true
                                                   }
                    }
                )
        }.sheet(isPresented: $isShowingSheet) {
            Text(Const.businessText).padding()
        }.background(Const.primaryColor)

    }
}

#Preview {
    SearchView()
}
