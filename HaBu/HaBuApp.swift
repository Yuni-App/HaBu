import SwiftUI
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = fcmToken {
            print("FCM registration token: \(fcm)")
        }
    }
}

@main
struct HaBuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService = AuthService.shared
    @State private var isLoading = true

    var body: some Scene {
        WindowGroup {
            Group {
                NavigationStack {
                    if isLoading {
                        SplashView()
                    } else {
                        if authService.user != nil {
                            TabbarView()
                        } else {
                            InfoView()
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
