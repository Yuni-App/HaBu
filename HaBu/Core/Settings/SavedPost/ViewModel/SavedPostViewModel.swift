//
//  SavedPostViewModel.swift
//  HaBu
//
//  Created by mert alp on 25.02.2024.
//

import Foundation

class SavedPostViewModel : ObservableObject {
    @Published var savedPostList :[Post]  = []
    static let shared = SavedPostViewModel()
    private var savedPostService = SavedPostService.shared

    func listenForSavedPost() async {
        await savedPostService.listenForSavedPost { result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    posts.forEach {post in
                        if !self.savedPostList.contains(post) {
                            self.savedPostList.append(post)
                        }
                    }
                }
            case .failure(let error):
                print("Bildirimler dinlenirken hata oluştu: \(error.localizedDescription)")
            }
        }
    }
    
    
    func stopListening(){
        savedPostService.stopListening()
    }
}
