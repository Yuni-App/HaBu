//
//  NotificationService.swift
//  HaBu
//
//  Created by mert alp on 10.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

protocol NotificationProvider {
    func fetchNotifications() async throws -> [Notification]
}
class NotificationService :NotificationProvider{
    private let db = Firestore.firestore()
    private let postService = PostService()

    func fetchNotifications() async throws -> [Notification] {
        do {
            let snapshot = try await db.collection("notification")
                .whereField("targetId", isEqualTo: AuthService.shared.currentUser?.id)
                        .getDocuments()
            // Firestore'dan alınan belgelerin dönüşüm işleminden önce işlemler
            let data = snapshot.documents.map { $0.data() }
            print("2rstdgfhk")
            // Dönüşüm işlemi
            var notifications: [Notification] = []
            for documentData in data {
                // Document verilerini dönüştürme işlemi
                guard let id = documentData["id"] as? String,
                      let postId = documentData["postId"] as? String,
                      let type = documentData["type"] as? String,
                      let userId = documentData["userId"] as? String,
                      let targetId = documentData["targetId"] as? String,
                      let createdAtTimestamp = documentData["createdAt"] as? Timestamp
                else {
                    throw NotificationError.missingData
                }
                let post = try await postService.fetchPost(id: postId)
                let user = try await UserService.fetchUser(withUserID: userId)
                      
                print("3rstdgfhk")
                // Bildirimi oluştur
                let notification = Notification(id: id, post: post, type: type, user: user, targetId: targetId, createdAt: createdAtTimestamp)
                
                notifications.append(notification)
            }
            print("4rstdgfhk")
            print(notifications.count)
            return notifications
        } catch {
            throw error
        }
    }

}

enum NotificationError: Error {
    case missingData
    case invalidFormat
}
