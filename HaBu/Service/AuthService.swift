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
    func createUser(email: String, password: String , username : String) async throws -> Void
    func forgotPassword(email: String) async throws -> Void
    func logOut() async throws -> Void
}

@MainActor
class AuthService : ObservableObject , AuthProvider {
    static let shared = AuthService()
    @Published var user: FirebaseAuth.User?
    
    func checkUser() async {
        do {
            if let currentUser = try await Auth.auth().currentUser{
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
            print(user?.email)
          
      
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
            let authResult = try await Auth.auth().createUser(withEmail:email, password: password)
            self.user = authResult.user
            // Oluşturulan kullanıcının UID'sini al
            let uid = authResult.user.uid
            
            // Firestore kullanıcı koleksiyonunu referans al
            let userCollection = Firestore.firestore().collection("user")
            
            // Kullanıcıyı Firestore koleksiyonuna ekle
            try await userCollection.document(uid).setData([
                "email": email,
                "username": username,
                "bio": "",
                "created_at": "",
                "depertmant": "",
                "faculty": "",
                "id": uid,
                "password": password,
                "profile_images":  [],
                "register_year": "",
                "surname":"",
                // Diğer kullanıcı özelliklerini buraya ekleyebilirsiniz
            ])
       
           
            print(user?.email)
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
    
    //tamamlandı
    func logOut() async throws -> Void{
        do {
            try await Auth.auth().signOut()
        } catch let error {
            print("hataaa")
            print(error)
        }
    }
    
    
    func forgotPassword(email: String) async throws -> Void {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch let error {
            if let authError = error as? NSError {
                print(authError.code)
                throw authError
            } else {
                let genericError = NSError(domain: "com.HaBu", code: 0, userInfo: [NSLocalizedDescriptionKey: "Bilinmeyen bir hata oluştu "])
                throw genericError
            }
        }
    }
}
