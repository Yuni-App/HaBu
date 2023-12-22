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
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func logOut(completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)
    func checkAuthenticationStatus(completion: @escaping (Result<Bool, Error>) -> Void)
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
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }

        func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
            guard let user = Auth.auth().currentUser else {
                // Kullanıcı oturumu açık değilse işlemi gerçekleştiremezsiniz.
                let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu açık değil."])
                completion(.failure(error))
                return
            }

            user.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    func logOut(completion: @escaping (Result<Void, Error>) -> Void) {
           do {
               try Auth.auth().signOut()
               completion(.success(()))
           } catch let error {
               completion(.failure(error))
           }
       }
    func checkAuthenticationStatus(completion: @escaping (Result<Bool, Error>) -> Void) {
         if let user = Auth.auth().currentUser {
             // Kullanıcı oturumu açık
             completion(.success(true))
         } else {
             // Kullanıcı oturumu kapalı
             completion(.success(false))
         }
     }
}

/*
 
 import SwiftUI

 struct ContentView: View {
     @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
     @StateObject private var authService = AuthService()  // Auth servisi

     var body: some View {
         Group {
             if isLoggedIn {
                 FeedView()
             } else {
                 LoginView()
             }
         }
         .onAppear {
             // Uygulama başladığında oturum durumunu kontrol et
             authService.checkAuthenticationStatus { result in
                 switch result {
                 case .success(let isAuthenticated):
                     // Oturum açık mı değil mi?
                     isLoggedIn = isAuthenticated
                 case .failure(let error):
                     // Hata durumu
                     print("Oturum durumu kontrol edilirken hata oluştu: \(error.localizedDescription)")
                 }
             }
         }
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }

 
 
 */
