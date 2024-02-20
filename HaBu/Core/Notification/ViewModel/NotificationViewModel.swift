//
//  NotificationViewModel.swift
//  HaBu
//
//  Created by mert alp on 10.02.2024.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notificationsData: [NotificationData] = []
    @Published var newNotificaitons : [NotificationData] = []
    @Published var okundu : Int = 0
    static let shared = NotificationViewModel()
    private var notificationService = NotificationService.shared
    // Bildirimleri Firestore'dan dinle
    func listenForNotifications() async {
        await notificationService.listenForNotifications() { result in
            switch result {
            case .success(let notifications):
                DispatchQueue.main.async {
                    notifications.forEach {noti in
                        if(noti.seen){
                            self.notificationsData.append(noti)
                        }
                        else {
                            self.newNotificaitons.append(noti)
                        }
                    }
                    if(self.okundu==0){
                        self.notificationsData = notifications
                        self.okundu = 1
                    }
                    else  {
                        let set1 = Set(notifications)
                        let set2 = Set(self.notificationsData)
                        let difference1 = set1.subtracting(set2)
                        self.newNotificaitons = Array(difference1)
                    }
                }
            case .failure(let error):
                print("Bildirimler dinlenirken hata oluştu: \(error.localizedDescription)")
            }
        }
        
    }
    func exitPage(){
        self.notificationService.seenNotification(notificationList: self.newNotificaitons)
        self.notificationsData.append(contentsOf: self.newNotificaitons)
        self.newNotificaitons.removeAll()
        
    }
    // Dinlemeyi durdur
    func stopListening() {
        notificationService.stopListening()
    }
}
