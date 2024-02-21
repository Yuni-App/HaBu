//
//  CommentService.swift
//  HaBu
//
//  Created by OmerErbalta on 19.02.2024.
//

import Foundation


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage



class CommentService{
    var commentRef = Firestore.firestore().collection("comment")
    
    func getComments(postId:String)async  ->[Comment]{
        do{
            var querySnapshot = try await commentRef.whereField("postId", isEqualTo: postId).getDocuments()
            var comments = try querySnapshot.documents.compactMap { try $0.data(as: Comment.self) }
            for  i in 0..<comments.count{
                comments[i].user = try await UserService.fetchUser(withUserID: comments[i].userId)
            }
            return comments
        }
        catch{
            print("CommentService Error")
            return []

        }
        
    }
}
