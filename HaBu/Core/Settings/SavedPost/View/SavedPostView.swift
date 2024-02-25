//
//  SavedPostView.swift
//  HaBu
//
//  Created by mert alp on 15.12.2023.
//

import SwiftUI

struct SavedPostView: View {
    @StateObject var savedPostVM = SavedPostViewModel.shared
    var body: some View {
        VStack{
            Text("Kaydedilenler")
            Text("\(savedPostVM.savedPostList.count)")
        }.onAppear {
            Task{
             await   savedPostVM.listenForSavedPost()
            }
        }
         .onDisappear {
            savedPostVM.stopListening()
        }
    }
}

#Preview {
    SavedPostView()
}
