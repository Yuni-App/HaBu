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

class AuthService : ObservableObject{
    @Published var user: FirebaseAuth.User?
    func checkUser() async {
            do {
                if let currentUser = try await  Auth.auth().currentUser{
                    self.user = currentUser
                }
            } catch {
                print("User check error: \(error.localizedDescription)")
            }
    }
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // Giriş başarılıysa result değerini kullanabilirsiniz
            user = result.user
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
  

    func createUser(email: String, password: String, username: String) async throws {
        do {
            // Firebase Authentication üzerinde kullanıcı oluştur
            let authResult = try await Auth.auth().createUser(withEmail:"olacak@gmail.com", password: "111111")
            
            // Oluşturulan kullanıcının UID'sini al
            let uid = authResult.user.uid
            
            // Firestore kullanıcı koleksiyonunu referans al
            let userCollection = Firestore.firestore().collection("user")
            
            // Kullanıcıyı Firestore koleksiyonuna ekle
            try await userCollection.document(uid).setData([
                "email": "olacak@gmail.com",
                "username": "mertalp009"
                // Diğer kullanıcı özelliklerini buraya ekleyebilirsiniz
                
            ])
            user = authResult.user
            // Giriş başarılıysa result değerini kullanabilirsiniz
        } catch {
            if let authError = error as? NSError {
                print("Auth Hata Kodu: \(authError.code)")
                throw authError
            } else if let firestoreError = error as? NSError {
                print("Firestore Hata Kodu: \(firestoreError.code)")
                throw firestoreError
            } else {
                let genericError = NSError(domain: "com.HaBu", code: 0, userInfo: [NSLocalizedDescriptionKey: "Bilinmeyen bir hata oluştu"])
                throw genericError
            }
        }
    }
    
    
    //Çalışmıyor 
    func isEmailInUse(email: String) async throws -> Bool {
           do {
               let methods = try await Auth.auth().fetchSignInMethods(forEmail: "a@gmail.com")
               print("aaa")
               print(methods)
               print(methods != nil && !methods.isEmpty)
               return methods != nil && !methods.isEmpty
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
    
    //çalışmıyor
    func checkUsernameAvailability(username: String) async throws -> Bool {
        let usernamesCollection = Firestore.firestore().collection("user")
        print("usernamesCollection")
        print(usernamesCollection)
        
        do {
            // Belirtilen kullanıcı adını içeren belgeyi sorgula
            let querySnapshot = try await usernamesCollection.whereField("user_name", isEqualTo: username).getDocuments()
            
            // Sorgudan dönen belge sayısına göre kullanıcı adının kullanılabilirliğini kontrol et
            let isAvailable = querySnapshot.documents.isEmpty
            print("isAvailable")
            print(isAvailable)
            return isAvailable
        } catch {
            if let firestoreError = error as? NSError {
                print("Firestore Hata Kodu: \(firestoreError.code)")
                
                throw firestoreError
            } else {
                let genericError = NSError(domain: "com.HaBu", code: 0, userInfo: [NSLocalizedDescriptionKey: "Bilinmeyen bir hata oluştu"])
                throw genericError
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
    func logOut() async throws -> Void{
        do {
            try await Auth.auth().signOut()
            } catch let error {}
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
