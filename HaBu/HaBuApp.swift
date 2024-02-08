//
//  HaBuApp.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import SwiftUI
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
@main
struct HaBuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService = AuthService.shared
    @State private var isLoading = true
    
    init() {

      
    }
       var body: some Scene {
           WindowGroup {
               Group {
                   NavigationStack{
                       if isLoading {
                           SplashView()
                       } else {
                           if authService.user != nil {
                               AddPostView()
                           } else {
                               AddPostView()
                           }
                       }
                   }
               }
               .onAppear {
                   Task {
                      try await authService.checkUser()
                       isLoading = false
                   }
               }
           }
       }
   }
