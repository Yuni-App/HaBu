//
//  AuthService.swift
//  HaBu
//
//  Created by mert alp on 19.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthProvider {
    func signIn(email: String, password: String) async throws -> Void
    func createUser(email: String, password: String) async throws -> Void
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func logOut(completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)
    func checkAuthenticationStatus(completion: @escaping (Result<Bool, Error>) -> Void)
}

class AuthService : AuthProvider{
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // Giriş başarılıysa result değerini kullanabilirsiniz
        } catch {
            if let authError = error as? NSError {
                print(authError.code)
                throw authError
            } else {
                let genericError = NSError(domain: "com.HaBu", code: 0, userInfo: [NSLocalizedDescriptionKey: "Bilinmeyen bir hata oluştu "])
                throw genericError
            }
        }
    }
    func createUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // Giriş başarılıysa result değerini kullanabilirsiniz
        } catch {
            if let authError = error as? NSError {
                print(authError.code)
                throw authError
            } else {
                let genericError = NSError(domain: "com.HaBu", code: 0, userInfo: [NSLocalizedDescriptionKey: "Bilinmeyen bir hata oluştu "])
                throw genericError
            }
        }
    }
    
    func checkUsernameAvailability(username: String, completion: @escaping (Bool) -> Void) {
        // Firebase'de kullanıcı adının mevcut olup olmadığını kontrol etmek için gereken işlemleri yapın.
        // Örneğin, bir Firestore koleksiyonunda kullanıcı adlarını takip edebilir veya başka bir benzeri yöntemi kullanabilirsiniz.
        
        // Bu sadece bir örnek ve projenize göre özelleştirmeniz gerekebilir.
        // Firestore kullanımınıza bağlı olarak, belirli bir koleksiyon ve doküman kullanabilirsiniz.
        // Aşağıdaki örnek, "usernames" adlı bir Firestore koleksiyonu içinde kullanıcı adlarını kontrol eder.
        
        let usernamesCollection = Firestore.firestore().collection("usernames")
        
        usernamesCollection.document(username).getDocument { (document, error) in
            if let document = document, document.exists {
                // Kullanıcı adı zaten alınmış
                completion(false)
            } else {
                // Kullanıcı adı kullanılabilir
                completion(true)
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
