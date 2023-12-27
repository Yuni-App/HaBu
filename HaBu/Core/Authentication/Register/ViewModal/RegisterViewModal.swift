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
    @Published var textUserName = ""
    @Published var isChecked : Bool = false
    
    @Published var errorMessage = ""
    @Published var completion = false
    @Published var error = false
    
    @Published var activeDestinaiton : AnyView?
    
    private var authService: AuthService
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func register ()async->Bool{
        guard !textEmail.isEmpty, !textPassword.isEmpty , !textAgainPassword.isEmpty , !textUserName.isEmpty else {
            if let errorMessage = ErrorMessage(rawValue: 1) {
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
        guard textPassword == textAgainPassword else {
            if let errorMessage = ErrorMessage(rawValue: 4) {
                print(errorMessage.description)
                self.errorMessage = errorMessage.description
                self.error = true
                self.completion = true
            }
            return false
        }
        
        guard isChecked == true else {
            if let errorMessage = ErrorMessage(rawValue: 5) {
                print(errorMessage.description)
                self.errorMessage = errorMessage.description
                self.error = true
                self.completion = true
            }
            return false
        }
        do {
            try await authService.createUser(email: textEmail, password: textPassword, username: textUserName)
            self.completion = true
            self.errorMessage = "Hesabınız oluşturuşdu mailinizi onaylayarak giriş yapabilirsiniz.."
            self.error = true
            return false
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
}
























/*
 
 func checkBuildFirst() async->Bool{
     guard !textEmail.isEmpty, !textPassword.isEmpty , !textAgainPassword.isEmpty else {
         if let errorMessage = ErrorMessage(rawValue: 1) {
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
     guard textPassword == textAgainPassword else {
         if let errorMessage = ErrorMessage(rawValue: 4) {
             print(errorMessage.description)
             self.errorMessage = errorMessage.description
             self.error = true
             self.completion = true
         }
         return false
     }
     
     do {
        let emailInUse  = try await authService.isEmailInUse(email: textEmail)
         print(emailInUse)
         if emailInUse {
             self.completion = true
             self.error = true
             self.errorMessage = "email zaten kullanımda"
             return false
         }else{
             self.completion = true
             return true
         }
    
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

 func checkBuildSecond()async -> Bool{
     guard !textName.isEmpty, !textSurname.isEmpty , !textUserName.isEmpty , !textAge.isEmpty , !textBio.isEmpty else {
         if let errorMessage = ErrorMessage(rawValue: 1) {
             print(errorMessage.description)
             self.errorMessage = errorMessage.description
             self.error = true
             self.completion = true
         }
         return false
     }
     do {
         
         let userNameCheck  = try await authService.checkUsernameAvailability(username: "OmerErbalta")
         print(userNameCheck)
         print(userNameCheck)
         if userNameCheck {
             self.completion = true
             self.error = true
             self.errorMessage = "kullanıcı adı zaten kullanımda"
             return false
         }else{
             self.completion = true
             return true
         }
    
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
 
 
 
 func signUp() async->Bool {
     
     guard !textFaculty.isEmpty, !textDepartment.isEmpty , !textYear.isEmpty else {
         if let errorMessage = ErrorMessage(rawValue: 1) {
             print(errorMessage.description)
             self.errorMessage = errorMessage.description
             self.error = true
             self.completion = true
         }
         return false
     }
     guard isChecked == true else {
         if let errorMessage = ErrorMessage(rawValue: 5) {
             print(errorMessage.description)
             self.errorMessage = errorMessage.description
             self.error = true
             self.completion = true
         }
         return false
     }
     do {
         print("textEmail")
         print(textEmail)
         try await authService.createUser(email: textEmail, password: textPassword, username: textUserName)
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
 */
