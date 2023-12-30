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
    @StateObject var rootVM = RootViewModel()
       var body: some Scene {
           WindowGroup {
               Group {
                   NavigationStack{
                       if rootVM.userSession == nil {
                           SplashView()
                       } 
                       else {
                           if authService.userSession != nil {
                               TabbarView()
                           } else {
                               ContentView()
                           }
                       }
                   }
                   .task {
                       print(rootVM.userSession)
                   }
               }
               .task {
                   Task{
                       let user = try await UserService.fetchUser(withUserID: "5S0ngdVuL2XjlFYoD2KQa4qVAJg1")
                       print(user.name)
                   }
               }
           }
       }
   }
