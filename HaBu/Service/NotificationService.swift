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
    func fetchNotifications() async throws -> [Notification] {
        do{
            let snapshot = try await Firestore.firestore().collection("notification")
                .getDocuments()
            
            let notifications = snapshot.documents.compactMap({try? $0.data(as:Notification.self)})
            
            print("noti")
            print(snapshot.documents.count)
            print(notifications)
            return notifications
        }
        catch{
            return []
        }
    }
    
    
}

