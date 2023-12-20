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
    @Published var againTextPassword = ""
    @Published var name = ""
    @Published var sureName = ""
    @Published var userName = ""
    @Published var age = ""
    @Published var bio = ""
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    private var authService: AuthService
       init(authService: AuthService) {
           self.authService = authService
       }

    
    func signUp() {
        print("sfdghj")
        print(name)
    }
    

       
}
