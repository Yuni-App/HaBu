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
    var postFeedRef = Firestore.firestore().collection("post") as Query
    func likeActionPost(userId:String,postId:String,like:Bool,targetUserId:String) async throws -> Bool{
        if like{
            do {
                try await postRef.document(postId).updateData([
                    "likeList": FieldValue.arrayUnion([userId])])
                let notificationDocumentRefrence = Firestore.firestore().collection("notification").document()
                try await notificationDocumentRefrence.setData([
                    "id":notificationDocumentRefrence.documentID,
                    "createdAt":Timestamp(date: .now),
                    "postId":postId,
                    "seen":false,
                    "targetId":targetUserId,
                    "type": NotificationType.postLike.rawValue,
                    "userId":userId
                ])
                
                await NotificationManager.sendPushNotification(caption: "Deneme 123", title: "deneme", fcm: "")
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
    
    func fetchPosts(tags: [String] = [], postType: String = "Hepsi") async -> [Post] {
        do {
            postFeedRef = Firestore.firestore().collection("post") as Query
            
            if postType == "Anonim"{
                postFeedRef =  postFeedRef.whereField("isAnonim", isEqualTo: true)
            }
            if postType == "Normal"{
                postFeedRef = postFeedRef.whereField("isAnonim", isEqualTo: false)
            }
            if !tags.isEmpty{
                postFeedRef = postFeedRef.whereField("tags", arrayContainsAny: tags)
            }
            let querySnapshot = try await postFeedRef.order(by: "timeStamp",descending: true).getDocuments()
            let posts = try querySnapshot.documents.compactMap { try $0.data(as: Post.self) }
            return posts
        } catch {
            print("Error fetching posts: \(error)")
            return []
        }
    }
    func listenForChanges(completion: @escaping ([Post]) -> Void) {
        postFeedRef.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let posts = documents.compactMap({ try? $0.data(as: Post.self) })
            print("listener \(posts.count)")
            completion(posts)
            print(posts.count)
            
        }
    }


    static func fetchPost(id: String) async -> Post? {
         do {
             let snapshot = try await Firestore.firestore().collection("post").document(id).getDocument()
             let post = try snapshot.data(as: Post.self)
             return post
         } catch {
             print("Post fetch error: \(error)")
             return nil
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
