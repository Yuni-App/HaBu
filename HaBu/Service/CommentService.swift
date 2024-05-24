import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class CommentService {
    var commentRef = Firestore.firestore().collection("comment")

    func getComments(postId: String) async -> [Comment] {
        do {
            let querySnapshot = try await commentRef.whereField("postId", isEqualTo: postId).getDocuments()
            var comments = try querySnapshot.documents.compactMap { try $0.data(as: Comment.self) }
            for i in 0..<comments.count {
                comments[i].user = try await UserService.fetchUser(withUserID: comments[i].userId)
            }
            return comments
        } catch {
            print("CommentService Error")
            return []
        }
    }

    func addComment(_ comment: String, postId: String,user:User) async -> Bool {
        guard let user = Auth.auth().currentUser else {
            print("User not logged in")
            return false
        }

        let newComment = Comment(
            id: UUID().uuidString,
            comment: comment,
            userId: user.uid,
            postId: postId,
            createdAt: Timestamp(date: .now)
        )

        do {
            try await commentRef.document(newComment.id).setData(from: newComment)
            print("Comment added successfully")
            return true
        } catch {
            print("Error adding comment: \(error.localizedDescription)")
            return false
        }
    }
}
