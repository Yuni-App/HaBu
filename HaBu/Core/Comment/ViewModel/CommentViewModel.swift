//
//  CommentViewModel.swift
//  HaBu
//
//  Created by OmerErbalta on 19.02.2024.
//

import Foundation


class CommentViewModel:ObservableObject{
    var commentService = CommentService()
    var postId : String
    @Published var comments : [Comment]? 
    init( postId: String) {
        self.postId = postId
        Task{
            comments = try await requestData()
            print("comments")
            print(comments)
        }
    }
    
    
    
    func requestData() async throws  -> [Comment]{
        
        let comments = await commentService.getComments(postId: postId)
        print(comments)
        return comments
        
    }
}
