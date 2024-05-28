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
        }
    }
    
    
    
    func requestData() async throws  -> [Comment]{
        
        let comments = await commentService.getComments(postId: postId)
        print(comments)
        return comments
    }
    func addComment(_ comment:String,postID:String,user:User)async throws{
            
        let status = await commentService.addComment(comment, postId: postID, user: user)
            
        if status {
            print("status")
            self.comments =  try await requestData()
            
            
        }
    }
}
