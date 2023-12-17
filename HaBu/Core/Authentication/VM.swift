//
//  VM.swift
//  HaBu
//
//  Created by mert alp on 17.12.2023.
//

import Foundation

extension InfoView {
    class AuthViewModel: ObservableObject, AuthenticationProtocol {
        
        @Published var isLoggedIn: Bool = false
        
        func login(username: String, password: String) {
            // Giriş işlemleri
            isLoggedIn = true
        }
        
        func signin(username: String, password: String) {
            // Kayıt işlemleri
            isLoggedIn = true
        }
    }
}
