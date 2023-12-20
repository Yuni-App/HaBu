//
//  LoginViewModal.swift
//  HaBu
//
//  Created by mert alp on 19.12.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var textEmail = ""
    @Published var textPassword = ""
    @Published var showingForgotPassword = false
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    private var authService: AuthService
       init(authService: AuthService) {
           self.authService = authService
       }

    
    func signIn() {
        // E-posta ve şifre boş mu kontrolü
        authService.signIn(email: textEmail, password: textPassword) {AuthResult in
            self.error = !AuthResult.success
            self.errorMessage = AuthResult.errorMessage
            self.completion = AuthResult.success
        }
    }
    
    func forgotPassoword(){
      //  authService.forgotPassoword()
    }
}
