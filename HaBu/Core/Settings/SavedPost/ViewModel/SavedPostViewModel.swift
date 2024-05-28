//
//  SavedPostViewModel.swift
//  HaBu
//
//  Created by mert alp on 25.02.2024.
//

import Foundation

@MainActor
class SavedPostViewModel : ObservableObject {
    @Published var savedPostList :[Post]  = []
    static let shared = SavedPostViewModel()
    private var savedPostService = SavedPostService.shared
    @Published var loading = true

    func fetchSavedPost() async throws{
        savedPostList = []
        if let savePostsId = AuthService.shared.currentUser?.savedPosts{
            for postId in savePostsId {
                if let post = await PostService.fetchPost(id: postId){
                    var post = post
                    post.user = try await UserService.fetchUser(withUserID: post.userId)
                    savedPostList.append(post)
                }
            }
        }
        loading = false
    }
    
}
