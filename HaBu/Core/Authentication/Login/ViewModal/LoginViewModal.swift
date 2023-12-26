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
    @Published var showingForgotPassword = false
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    @Published var activeDestinaiton : AnyView?
    private var authService: AuthService
    init(authService: AuthService) {
        self.authService = authService
    }

    func signIn2() async ->Bool {
            do {
                try await authService.signIn2(email: textEmail, password: textPassword)
                // Giriş başarılıysa yapılacak işlemler
                self.completion = true
                return true
            } catch {
                errorMessage = error.localizedDescription
                self.errorMessage = error.localizedDescription
                self.error = true
                self.completion = true
                return false 
            }
        }
func signIn()-> Bool {

        guard !textEmail.isEmpty, !textPassword.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                print(errorMessage.description)
                self.errorMessage = "Lütfen Tüm Alanaları Doldurunuz"
                self.error = true
                self.completion = true
                
            }
        return false
        }
        guard textEmail.isValidEmail else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = "Geçerli bir eposta giriniz"
                self.error = true
                self.completion = true
                
            }
        return false
        }
        guard textPassword.count >= 6 else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = "şifre en az 6 karakterli olmalı"
                self.error = true
                self.completion = true
                
            }
        return false
        }
    
        var signInSuccess = false
        authService.signIn(email: textEmail, password: textPassword) { result in
        print("sdffgsd")
        print(result)
        switch result {
        case .success(let result):
            signInSuccess = true
            self.completion = true
            
         
        case .failure(let error as NSError):
            if let errorMessage = ErrorMessage(rawValue: error.code) {
                print("çalıştı girdi4")
                print(errorMessage.description)
                print("çalıştı girdi5")
                self.errorMessage = error.localizedDescription
                self.error = true
                self.completion = true
                signInSuccess = false
                print("çalıştı girdi6")
                
            } else {
                self.errorMessage = "Bir Hata Oluştu"
                self.error = true
                self.completion = true
                signInSuccess = false
            }
        }
    }
    print("signInSuccess")
    print(signInSuccess)
    return signInSuccess
   
}
    func forgotPassoword(){
        //  authService.forgotPassoword()
    }
}
    
 

