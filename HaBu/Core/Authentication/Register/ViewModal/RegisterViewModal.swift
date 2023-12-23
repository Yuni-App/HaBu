//
//  RegisterViewModal.swift
//  HaBu
//
//  Created by mert alp on 20.12.2023.
//

import Foundation

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
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    private var authService: AuthService
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signUp() {
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
        authService.signUp(email: textEmail, password: textPassword) { result in
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
        
    }
    
}
