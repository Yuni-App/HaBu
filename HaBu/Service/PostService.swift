//
//  PostService.swift
//  HaBu
//
//  Created by mert alp on 2.01.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol PostProvider{
     func createPost(textContent : String , selectedTags : [String] , isAnonimComment : Bool , isAnonim : Bool) async throws -> Void
    // static func fetchPost( postID: String) async throws -> Post
    // static func fetchPosts() async throws ->  [Post]
}

enum PostError : Error{
    case serverError
    case parsingError
}
class PostService : PostProvider{

    
    func fetchPosts() async -> [Post]{
        do {
            let snapshot = try await Firestore.firestore().collection("post").getDocuments()
            let posts = snapshot.documents.compactMap({try? $0.data(as:Post.self)})
            return posts
        }
        catch{
            print("error")
            return []
        }
    }
    
    
   
    func createPost(textContent : String , selectedTags : [String] , isAnonimComment : Bool ,isAnonim : Bool) async throws {
        let authService = AuthService.shared
        do {
            let userCollection = Firestore.firestore().collection("post")
            let documentReference = userCollection.document()
            try await documentReference.setData([
                "id": documentReference.documentID,
                "userId": authService.user?.uid,
                "isAnonim": isAnonim,
                "isAnonimComment": isAnonimComment,
                "caption": textContent,
                "tags": selectedTags,
                "imageUrl": ["https://example.com/image.jpg","https://example.com/image.jpg"],
                "timeStamp": FieldValue.serverTimestamp(),
                "likeList": []
            ])
            print("Belge başarıyla eklendi.")
        } catch {
            print("Belge eklenirken bir hata oluştu: \(error.localizedDescription)")
        }
        
    }
}
