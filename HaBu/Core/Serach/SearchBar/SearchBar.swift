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
                    
                
            }
            .animation(.bouncy(duration: 0.9))
            .padding(.horizontal)
    }
}

#Preview {
    SearchBar(searchText: .constant(""), isEditing: .constant(false))
}
