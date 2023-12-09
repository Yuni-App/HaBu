//
//  SearchBar.swift
//  HaBu
//
//  Created by yusuf on 4.12.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool
    @Binding var isSecondSearchViewActive: Bool
    var body: some View {
            HStack {
                TextField("Ara...", text: $searchText)
                    .padding(8)
                    .padding(.horizontal, 35)
                    .overlay(
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                            .frame(alignment: .leading),
                        alignment: .leading
                    )
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onTapGesture {
                        isEditing = true
                        isSecondSearchViewActive = true
                    }
                if isEditing {
                    Button(action: {
                        searchText = ""
                        isEditing = true
                        
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(8).onTapGesture {
                                searchText = ""
                            }
                    }
                }
            }
            .animation(.bouncy(duration: 0.9))
            .padding(.horizontal)
    }
}

#Preview {
    SearchBar(searchText: .constant(""), isEditing: .constant(false), isSecondSearchViewActive: .constant(false))
}
