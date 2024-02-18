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
class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationData] = []
    @Published var newNotificaiton : [NotificationData] = []
    @Published var okundu : Int = 0
    private var notificationService = NotificationService.shared
    
    // Bildirimleri Firestore'dan dinle
    func listenForNotifications() async {
        await notificationService.listenForNotifications() { result in
            switch result {
            case .success(let notifications):
                DispatchQueue.main.async {
                    if(self.okundu==0){
                        self.notifications = notifications
                        self.okundu = 1
                    }
                    else  {
                        let set1 = Set(notifications)
                        let set2 = Set(self.notifications)
                        let difference1 = set1.subtracting(set2)
                        self.newNotificaiton = Array(difference1)
                       
                    }
                }
            case .failure(let error):
                print("Bildirimler dinlenirken hata oluştu: \(error.localizedDescription)")
            }
        }
        
    }
    func exitPage(){
        self.okundu = 1
        self.notifications.append(contentsOf: self.newNotificaiton)
        self.newNotificaiton.removeAll()
        
    }
    // Dinlemeyi durdur
    func stopListening() {
        notificationService.stopListening()
    }
}
