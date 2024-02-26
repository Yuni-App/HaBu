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
                    self.notificationsData.removeAll()
                    self.newNotificaitons.removeAll()
                    notifications.forEach {noti in
                        if(noti.seen){
                          
                            if !self.notificationsData.contains(noti) {
                                self.notificationsData.append(noti)
                            }
                        }
                        else {
              
                            if !self.newNotificaitons.contains(noti) {
                                
                                self.newNotificaitons.append(noti)
                            }
                            
                            
                        }
                    }
                    
                    
                  

                    // notificationsData listesini timestampe göre sırala
                    self.notificationsData.sort(by: compareByTimestamp)

                    // newNotificaitons listesini timestampe göre sırala
                    self.newNotificaitons.sort(by: compareByTimestamp)

                    
                    
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
        self.notificationsData.sort(by: compareByTimestamp)

        // newNotificaitons listesini timestampe göre sırala
        
    }
    // Dinlemeyi durdur
    func stopListening() {
        notificationService.stopListening()
    }
}

func compareByTimestamp(_ data1: NotificationData, _ data2: NotificationData) -> Bool {
    return data1.createdAt.dateValue() > data2.createdAt.dateValue()
}
