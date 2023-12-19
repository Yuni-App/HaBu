//
//  AuthViewModal.swift
//  HaBu
//
//  Created by mert alp on 19.12.2023.
//

import Foundation
//import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false

    func checkUserLoggedIn() {
        if let _ = Auth.auth().currentUser {
            // Kullanıcı oturum açmışsa
            isAuthenticated = true
        } else {
            // Kullanıcı oturum açmamışsa
            isAuthenticated = false
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Giriş başarısız
                print("Giriş başarısız: \(error.localizedDescription)")
            } else {
                // Giriş başarılı
                self.isAuthenticated = true
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            // Çıkış başarılı
            isAuthenticated = false
        } catch let signOutError as NSError {
            // Çıkış başarısız
            print("Çıkış başarısız: \(signOutError.localizedDescription)")
        }
    }
}
