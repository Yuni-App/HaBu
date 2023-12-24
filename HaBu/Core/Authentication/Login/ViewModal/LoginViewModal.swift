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
    
    func signIn() async ->Bool {
        guard !textEmail.isEmpty, !textPassword.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                print(errorMessage.description)
                self.errorMessage = errorMessage.description
                self.error = true
                self.completion = true
                
            }
            return false
        }
        guard textEmail.isValidEmail else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = errorMessage.description
                self.error = true
                self.completion = true
                
            }
            return false
        }
        guard textPassword.count >= 6 else {
            if let errorMessage = ErrorMessage(rawValue: 3) {
                print(errorMessage.description)
                self.errorMessage = errorMessage.description
                self.error = true
                self.completion = true
            }
            return false
        }
        do {
            try await authService.signIn(email: textEmail, password: textPassword)
            self.completion = true
            return true
        } catch {
            if let authError = error as? NSError {
                if let errorMessage = ErrorMessage(rawValue: authError.code) {
                    print(errorMessage.description)
                    self.errorMessage = errorMessage.description
                    self.error = true
                    self.completion = true
                    return false
                }
            }
            self.errorMessage = "Beklenemdik bir hata oluştu"
            return false
        }
    }
    
    func forgotPassoword(){
        //  authService.forgotPassoword()
    }
}



