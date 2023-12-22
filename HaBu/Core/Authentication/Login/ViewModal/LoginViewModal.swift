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

        guard !textEmail.isEmpty, !textPassword.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                print(errorMessage.description)
                
            }
        return
        }
        guard textEmail.isValidEmail else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                
            }
        return
        }
    authService.signIn(email: textEmail, password: textPassword) { result in
        switch result {
        case .success(let result):
            print(result)
        case .failure(let error as NSError):
            if let errorMessage = ErrorMessage(rawValue: error.code) {
                print(errorMessage.description)
                
            } else {
                print("Bilinmeyen bir hata oluştu.")
            }
        }
    }
    // E-posta ve şifre boş mu kontrolü
}
}
    
    func forgotPassoword(){
        //  authService.forgotPassoword()
    }

