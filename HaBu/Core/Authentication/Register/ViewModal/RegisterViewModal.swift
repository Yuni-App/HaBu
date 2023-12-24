//
//  RegisterViewModal.swift
//  HaBu
//
//  Created by mert alp on 20.12.2023.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var textEmail = ""
    @Published var textPassword = ""
    @Published var textAgainPassword = ""
    @Published var textName = ""
    @Published var textSurname = ""
    @Published var textUserName = ""
    @Published var textAge = ""
    @Published var textBio = ""
    @Published var textFaculty = ""
    @Published var textDepartment = ""
    @Published var textYear = ""
    @Published var isChecked : Bool = false
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    @Published var activeDestinaiton : AnyView?
    
    private var authService: AuthService
    init(authService: AuthService) {
        self.authService = authService
    }
    
    
    func checkBuildFirst()->Bool{
        guard !textEmail.isEmpty, !textPassword.isEmpty , !textAgainPassword.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                self.errorMessage = "Lütfen Tüm Alanaları Doldurunuz"
                self.error = true
                self.completion = true
            }
            return false
        }
        guard textEmail.isValidEmail else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = "Geçerli Bir Mail Giriniz"
                self.error = true
                self.completion = true
            }
            
            return false
        }
        guard textPassword.count >= 6 else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = "Şifre en az 6 karakterli olmalı"
                self.error = true
                self.completion = true
            }
            
            return false
        }
        guard textPassword == textAgainPassword else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = "Şifreler Eşleşmiyor"
                self.error = true
                self.completion = true
            }
            return false
        }
        return true
    }
    func checkBuildSecond()->Bool{
        guard !textName.isEmpty, !textSurname.isEmpty , !textUserName.isEmpty , !textAge.isEmpty , !textBio.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                print(errorMessage.description)
                self.errorMessage = "Lütfen Tüm Alanaları Doldurunuz"
                self.error = true
                self.completion = true
            }
            return false
        }
        authService.checkUsernameAvailability(username: textUserName) { isAvailable in
            if isAvailable {
                // Kullanıcı adı alınmamış, işlemleri devam ettir
                print("Kullanıcı adı kullanılabilir.")
                self.completion = true
            } else {
                // Kullanıcı adı zaten alınmış
                if let errorMessage = ErrorMessage(rawValue: 1) {
                    print(errorMessage.description)
                    self.errorMessage = "Kullanıcı adı zaten alınmış"
                    self.error = true
                    self.completion = true
                }
            }
        }
        return true
    }
    func signUp()->Bool {
        
        guard !textFaculty.isEmpty, !textDepartment.isEmpty , !textYear.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
                print(errorMessage.description)
                self.errorMessage = "Lütfen Tüm Alanaları Doldurunuz"
                self.error = true
                self.completion = true
            }
            return false
        }
        guard isChecked == true else {
            if let errorMessage = ErrorMessage(rawValue: 2) {
                print(errorMessage.description)
                self.errorMessage = "Gizlilik Sözleşmesini Onaylayınız"
                self.error = true
                self.completion = true
            }
            return false
        }
        
        var signUpSuccess = false
        authService.signUp(email: textEmail, password: textPassword) { result in
            switch result {
            case .success(let result):
                print(result)
                self.completion = true
                signUpSuccess = true
                
            case .failure(let error as NSError):
                if let errorMessage = ErrorMessage(rawValue: error.code) {
                    print(errorMessage.description)
                    self.errorMessage = errorMessage.description
                    self.error = true
                    self.completion = true
                    signUpSuccess = false
                    
                } else {
                    self.errorMessage = "Bir Hata Oluştu"
                    self.error = true
                    self.completion = true
                    signUpSuccess = false
                }
            }
        }
        
        return signUpSuccess
        
    }
}

