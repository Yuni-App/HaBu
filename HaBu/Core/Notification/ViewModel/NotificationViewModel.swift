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
    @Published var sayac : Int = 0
    private var notificationService = NotificationService.shared
    

    
    // Bildirimleri Firestore'dan dinle
    func listenForNotifications() async {
        await notificationService.listenForNotifications() { result in
            switch result {
            case .success(let notifications):
                DispatchQueue.main.async {
                    if(self.sayac==0){
                        self.notifications = notifications
                        self.sayac = 1
                    }
                    else  {
                        self.newNotificaiton = notifications
                    }
                }
            case .failure(let error):
                print("Bildirimler dinlenirken hata oluştu: \(error.localizedDescription)")
            }
        }
        
    }
    
    // Dinlemeyi durdur
    func stopListening() {
        notificationService.stopListening()
    }
}
