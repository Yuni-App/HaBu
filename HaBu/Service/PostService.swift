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
import FirebaseStorage

protocol PostProvider{
     func createPost(textContent : String , selectedTags : [String] , isAnonimComment : Bool , isAnonim : Bool, selectedImages: [UIImage]) async throws -> Void
    // static func fetchPost( postID: String) async throws -> Post
    // static func fetchPosts() async throws ->  [Post]
}

enum PostError : Error{
    case serverError
    case parsingError
}
class PostService : PostProvider{
    var postRef = Firestore.firestore().collection("post")
    
    
    func likeActionPost(userId:String,postId:String,like:Bool) async throws -> Bool{
        if like{
            do {
                try await postRef.document(postId).updateData([
                    "likeList": FieldValue.arrayUnion([userId])])
                return true
            }
            catch{
                return false
            }
        }
        else{
            do {
                try await postRef.document(postId).updateData([
                    "likeList": FieldValue.arrayRemove([userId])
                ])
                return true
            }
            catch{
                return false
            }

        }
    }
    
    func fetchPosts() async -> [Post]{
        do {
            let snapshot = try await Firestore.firestore().collection("post").getDocuments()
            let posts = snapshot.documents.compactMap({try? $0.data(as:Post.self)})
            return posts
        }
        catch{
            return []
        }
    }
    func fetchPost(id : String) async -> Post{
        do {
            let snapshot = try await Firestore.firestore().collection("post").document(id).getDocument()
            let post = try snapshot.data(as: Post.self)
            return post
        }
        catch{
            return Post.MockData[0]
        }
    }
    
    
   
    func createPost(textContent : String , selectedTags : [String] , isAnonimComment : Bool ,isAnonim : Bool, selectedImages: [UIImage]) async throws {
        let authService = AuthService.shared
        var uploadedImageURLs: [String] = []
        do {
            let userCollection = Firestore.firestore().collection("post")
            let documentReference = userCollection.document()
            if !selectedImages.isEmpty {
                for image in selectedImages {
                    if let imageUrl = try? await ImageUploder.imageUpload(image: image, targetFile: .profileFile, id: documentReference.documentID){
                        uploadedImageURLs.append(imageUrl)
                    }
                }
            }
            print(uploadedImageURLs)
            try await documentReference.setData([
                "id": documentReference.documentID,
                "userId": authService.user?.uid,
                "caption": textContent,
                "imageUrl": uploadedImageURLs,
                "timeStamp": FieldValue.serverTimestamp(),
                "likeList": [],
                "isAnonim": isAnonim,
                "isAnonimComment": isAnonimComment,
                "tags": selectedTags,
            ])
            print("Belge başarıyla eklendi.")
        } catch {
            print("Belge eklenirken bir hata oluştu: \(error.localizedDescription)")
        }
        
    }
}

