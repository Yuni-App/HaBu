//
//  LoginViewModal.swift
//  HaBu
//
//  Created by mert alp on 19.12.2023.
//

import Foundation
import FirebaseAuth
import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var textEmail = ""
    @Published var textPassword = ""
    @Published var isActiveDestination = false
    
    @Published var showingForgotPassword = false
    @Published var textForgotEmail : String = ""
    
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    
    
    private var authService: AuthService
    init(authService: AuthService) {
        self.authService = authService
    }
    
    //TODO: SIGN IN METHOD
    func signIn() async ->Bool {
        guard !textEmail.isEmpty, !textPassword.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
                
            }
            return false
        }
        guard textEmail.isValidEmail else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
                
            }
            return false
        }
        guard textPassword.count >= 6 else {
            if let errorMessage = ErrorMessage(rawValue: 3) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
            }
            return false
        }
        do {
            try await authService.signIn(email: textEmail, password: textPassword)
            print("Başarılı giriş yapılıyor.")
            isActiveDestination = true
            return true
        } catch let error as NSError{
            if let errorMessage = ErrorMessage(rawValue: error.code) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
                return false
            }
            self.showAlert = true
            self.alertTitle = "Hata!!"
            self.alertMessage = "Beklenmedik bir hata oluştu"
            print("Beklenmedik bir hata oluştu")
            return false
        }
    }
    
    
    
    
    
    
    
    //TODO: RESET PASSWORD METHOD
    func resetPassword() async {
        guard !textForgotEmail.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
            }
            return
        }
        
        guard textForgotEmail.isValidEmail else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
            }
            return
        }
        do {
            try await authService.forgotPassword(email: textForgotEmail)
            self.showAlert = true
            self.alertTitle = "Başarılı.."
            self.alertMessage = "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi."
            
            print("Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.")
            
        } catch let error as NSError{
            if let errorMessage = ErrorMessage(rawValue: error.code) {
                self.showAlert = true
                self.alertTitle = "Hata!!"
                self.alertMessage = errorMessage.description
                print(errorMessage.description)
            }
          
        }
    }
    
}



