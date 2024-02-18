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
class NotificationService {
    static let shared = NotificationService()
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    

    func listenForNotifications( completion: @escaping (Result<[NotificationData], Error>) -> Void) async {
       // var notificationDatas : [NotificationData] = []
        let query = await db.collection("notification").whereField("targetId", isEqualTo: AuthService.shared.currentUser?.id)
        
        listener = query.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                var notifications = snapshot.documents.compactMap { document -> NotificationData? in
                    do {
                        let notification = try document.data(as: NotificationData.self)
                        // Kullanıcı ve post verilerini al
                        return notification
                    } catch {
                        print("Bildirim çözümlenemedi: \(error.localizedDescription)")
                        return nil
                    }
                }
               
               // var notificationDatas: [NotificationData] = notifications // Burada notificationDatas'ı oluştur
                
                // Dinleyici işlemi tamamlandıktan sonra for döngüsünü çalıştır
                DispatchQueue.main.async {
                    Task {
                        for i in 0..<notifications.count {
                            let post =  await PostService.fetchPost(id: notifications[i].postId)
                            if let post = post {
                                notifications[i].post = post
                                print("Post: \(post)")
                            }
                            
                            do {
                                let user = try await UserService.fetchUser(withUserID: notifications[i].userId)
                                notifications[i].user = user
                                print("User: \(user)")
                            } catch {
                                print("hata")
                            }
                        }
                     
                        completion(.success(notifications))
                    }
                }
            }
        }

     
       
    }
    
    // Dinleme durdur
    func stopListening() {
        listener?.remove()
    }
}
