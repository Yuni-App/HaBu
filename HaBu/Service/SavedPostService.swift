import Foundation
import FirebaseFirestore

protocol SavedPostProvider {
    func listenForSavedPost(completion: @escaping (Result<[Post], Error>) -> Void) async
    func stopListening()
    func savePost(postId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func unsavePost(postId: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class SavedPostService: SavedPostProvider {
    static let shared = SavedPostService()
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    func listenForSavedPost(completion: @escaping (Result<[Post], Error>) -> Void) async {
        guard let userId = await AuthService.shared.currentUser?.id else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])))
            return
        }

        let userRef = db.collection("user").document(userId)
        
        listener = userRef.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot, let data = snapshot.data(), let postsId = data["savedPosts"] as? [String] {
                DispatchQueue.main.async {
                    Task {
                        var posts: [Post] = []
                        for postId in postsId {
                            let post = await PostService.fetchPost(id: postId)
                            if let post = post {
                                posts.append(post)
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

    @MainActor
    func savePost(postId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = AuthService.shared.currentUser?.id else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])))
            return
        }

        let userRef = db.collection("user").document(userId)
        
        userRef.updateData([
            "savedPosts": FieldValue.arrayUnion([postId])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    @MainActor
    func unsavePost(postId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = AuthService.shared.currentUser?.id else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])))
            return
        }

        let userRef = db.collection("user").document(userId)
        
        userRef.updateData([
            "savedPosts": FieldValue.arrayRemove([postId])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
