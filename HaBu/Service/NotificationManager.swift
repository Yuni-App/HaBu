//
//  NotificationManager.swift
//  HaBu
//
//  Created by OmerErbalta on 20.02.2024.
//

import Foundation
import UserNotifications

@MainActor
class NotificationManager: ObservableObject{
    @Published private(set) var hasPermission = false
    
    init() {
        Task{
            await getAuthStatus()
        }
    }
    
    static func sendPushNotification(caption:String,title:String,fcm:String){
        let receiverFCM = AuthService.shared.fcm 
            let serverKey = "AAAAdU2Gzmo:APA91bG0fH25beBLZaPuEOek7caU3OAhHQbHt0pi5XP5D67Y7yN0JoE1XrwtS1Tj7l-Gl55yDmkH-8SdiSYDzYymH2lGeMi-Qu4kVAvRTWMJeVXTpy4Acw47z_L1umA2B5saT-lR-Nfl"
            
            let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set the request headers
            request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Set the request body data
            let requestBody: [String: Any] = [
                "to": receiverFCM,
                "notification": [
                    "title": title,
                    "body": caption
                ]
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) {
                request.httpBody = jsonData
                
                // Send the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    if let data = data {
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Response: \(responseString)")
                        }
                    }
                }.resume()
            }
        }
    
    func request() async{
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
             await getAuthStatus()
        } catch{
            print(error)
        }
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            hasPermission = true
        default:
            hasPermission = false
        }
    }
}
