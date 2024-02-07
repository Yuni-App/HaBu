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
    
    
   
    func createPost(textContent : String , selectedTags : [String] , isAnonimComment : Bool ,isAnonim : Bool, selectedImages: [UIImage]) async throws {
        let authService = AuthService.shared
        var uploadedImageURLs: [String] = []
        do {
            let userCollection = Firestore.firestore().collection("post")
            let documentReference = userCollection.document()
            if !selectedImages.isEmpty {
                
                for image in selectedImages {
                    if let imageUrl = try? await ImageUploder.imageUpload(image: image, targetFile: .profileFile, postId: documentReference.documentID){
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

