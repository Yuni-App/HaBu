//
//  AuthService.swift
//  HaBu
//
//  Created by mert alp on 19.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void)
    func forgotPassword()
 //   func signUp(email: String, password: String, passwordAgain: String, completion: @escaping (AuthResult) -> Void)
    func logOut()
}




class AuthService: AuthProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as? NSError {
                completion(.failure(error))
            }
           else if let result = result {
               completion(.success(result))
            }
        }
    }
      
    
    func forgotPassword() {}
   // func signUp(email: String, password: String,passwordAgain : String ,  completion: @escaping (AuthResult) -> Void){}
    func logOut(){}
}

/*
 
 guard !email.isEmpty, !password.isEmpty else {
     completion(AuthResult(success: false, errorMessage: .emptyFields))
     return
 }
 // E-posta format kontrolü
 guard email.isValidEmail else {
     completion(AuthResult(success: false, errorMessage: .invalidEmail))
     return
 }
 */
/*
 
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
 */
