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
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void)
    func forgotPassword()
    func logOut()
    func deleteAccount()
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
      
    

    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void) {
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
    func logOut(){}
    func deleteAccount(){}
}

