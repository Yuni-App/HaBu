//
//  LogOutViewModel.swift
//  HaBu
//
//  Created by mert alp on 24.12.2023.
//

import Foundation

class LogOutViewModel :ObservableObject {
    private var authService: AuthService
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func logout() async ->Bool {
        do {
            try await authService.logOut()
            return true
        } catch {
            return false
        }
        }
    }
    
    

