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

    enum ErrorMessage: Int  {
        case emptyFields = 1
        case invalidEmail = 2
        case wrongPassword = 17009
        case userNotFound = 4
        case authenticationError = 5
        
        var description: String {
            switch self {
            case .emptyFields:
                return "E-posta ve şifre alanları boş bırakılamaz."
            case .invalidEmail:
                return "Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin."
            case .wrongPassword:
                return "Yanlış şifre. Lütfen doğru şifreyi girin."
            case .userNotFound:
                return "Kullanıcı bulunamadı. Lütfen kayıtlı bir e-posta adresi kullanın veya hesap oluşturun."
            case .authenticationError:
                return "Kimlik doğrulama hatası. Lütfen tekrar deneyin."
            }
        }
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

