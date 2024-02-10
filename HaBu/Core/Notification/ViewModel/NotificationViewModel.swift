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
    @Published var notifications: [Notification] = []
    private let notificationService = NotificationService()
    
    init() {
        Task {
            do {
                try await requestData()
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
}
