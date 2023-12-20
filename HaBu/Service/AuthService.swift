//
//  AuthService.swift
//  HaBu
//
//  Created by mert alp on 19.12.2023.
//

import Foundation
import FirebaseAuth

protocol AuthProtocol {
    func signIn(email: String, password: String, completion: @escaping (AuthResult) -> Void)
    func forgotPassword()
    func signUp(email: String, password: String, passwordAgain: String, completion: @escaping (AuthResult) -> Void)
    func logOut()
}

class AuthResult {
    var success : Bool = false
    var errorMessage : String = ""
    init(success : Bool, errorMessage: ErrorMessage) {
        self.success = success
        self.errorMessage = errorMessage.description
    }
}

enum ErrorMessage {
    case emptyFields
    case invalidEmail
    case wrongPassword
    case userNotFound
    case authenticationError

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



class AuthService: AuthProtocol {

    
    func signIn(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
           Auth.auth().signIn(withEmail: email, password: password) { (res, error) in
               
               guard !email.isEmpty, !password.isEmpty else {
                   completion(AuthResult(success: false, errorMessage: .emptyFields))
                   return
               }
               // E-posta format kontrolü
               guard email.isValidEmail else {
                   completion(AuthResult(success: false, errorMessage: .invalidEmail))
                   return
               }

               Auth.auth().signIn(withEmail: email, password: password) { result, error in
                   if let error = error as? NSError {
                       print("Authentication error: \(error.localizedDescription)")
                       switch error.code {
                       case AuthErrorCode.invalidEmail.rawValue:
                           completion(AuthResult(success: false, errorMessage: .invalidEmail))
                       case AuthErrorCode.wrongPassword.rawValue:
                           completion(AuthResult(success: false, errorMessage: .wrongPassword))
                       case AuthErrorCode.userNotFound.rawValue:
                           completion(AuthResult(success: false, errorMessage: .userNotFound))
                       default:
                           completion(AuthResult(success: false, errorMessage: .authenticationError))
                       }
                   } else {
                       print("Sign-in successful")
                       //update
                       completion(AuthResult(success: true, errorMessage: .authenticationError))
                   }
               }
           }
       }
    
    func forgotPassword() {}
  
    func signUp(email: String, password: String,passwordAgain : String ,  completion: @escaping (AuthResult) -> Void){}
    func logOut(){}

}
