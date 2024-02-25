//
//  SavedPostService.swift
//  HaBu
//
//  Created by mert alp on 25.02.2024.
//

import Foundation
import FirebaseFirestore
protocol SavedPostProvider{
    func listenForSavedPost( completion: @escaping (Result<[Post], Error>) -> Void) async
    func stopListening ()
}

class SavedPostService : SavedPostProvider {
    static let shared = SavedPostService()
    private let db = Firestore.firestore()
    private var listener : ListenerRegistration?
   

    func listenForSavedPost(completion: @escaping (Result<[Post], Error>) -> Void) async {
        var postsId : [String] = []
        var posts: [Post] = []
        let savedPostRef = await db.collection("user").document(AuthService.shared.currentUser!.id).collection("savedPost")
        
        listener = savedPostRef.addSnapshotListener{snapshot , error in
            if let error = error {
                completion(.failure(error))
            }else if let snapshot = snapshot {
                for document in snapshot.documents {
                       let postID = document.documentID
                        postsId.append(postID)
                    }
                DispatchQueue.main.async {
                    Task {
                        for i in 0..<postsId.count {
                            let post =  await PostService.fetchPost(id: postsId[i])
                            if let post = post {
                                posts.append(post) 
                                print("Post: \(post)")
                            }
                        }
                        completion(.success(posts))
                    }
                }
            }
        }
    }
    
    func stopListening() {
        listener?.remove()
    }
    
 
    
}
