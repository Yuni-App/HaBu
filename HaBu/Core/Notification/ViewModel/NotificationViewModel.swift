//
//  NotificationViewModel.swift
//  HaBu
//
//  Created by mert alp on 10.02.2024.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa
@MainActor
class NotificationViewModel: ObservableObject {
    
@Published var notifications: [Notification] = []
private let notificationService = NotificationService()
private var listener: ListenerRegistration?
var data: [[String: Any]] = []

init() {
    Task {
        do {
            try await requestData()
          
            try await convertDataToNotifications()
        } catch {
            print("Error requesting data: \(error)")
        }
    }
}

func requestData() async throws {
    let fetchedNotifications = try await notificationService.fetchNotifications()
    DispatchQueue.main.async {
        self.notifications = fetchedNotifications
    }
}

    func startListening(){
        listener = Firestore.firestore().collection("notification")
            .whereField("targetId", isEqualTo: AuthService.shared.currentUser?.id)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error listening for notifications: \(error)")
                    return
                }

                guard let snapshot = snapshot else {
                    print("Error fetching notifications: Snapshot is nil")
                    return
                }

                // Firestore'dan alınan belgelerin dönüşüm işleminden önce işlemler
                do {
                    self.data = snapshot.documents.map { $0.data() }
                    
                } catch {
                    print("Error decoding notifications: \(error)")
                }
            }
}

private func convertDataToNotifications() async throws {
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

        // Bildirimdeki post ve user verilerini getirme
        let post = try await PostService.fetchPost(id: postId)
        let user = try await UserService.fetchUser(withUserID: userId)

        // Bildirimi oluştur
        let notification = Notification(id: id,
                                         post: post,
                                         type: type,
                                         user: user,
                                         targetId: targetId,
                                         createdAt: createdAtTimestamp)

        notifications.append(notification)
    }
print("sdghfjkh")
    // Yeni bildirimleri ana iş parçacığında güncelle
    DispatchQueue.main.async {
        self.updateNotifications(notifications)
    }
    print("sdghfjkh")

}

private func updateNotifications(_ notifications: [Notification]) {
    print("sdghfjkh")

    self.notifications = notifications
    
}
}
