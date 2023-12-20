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

    
    func signUp() {}
    

       
}
