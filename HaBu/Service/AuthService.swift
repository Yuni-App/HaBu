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
    
    //TODO: USER CHECK
    func checkUser() async {
        do {
            if let currentUser = Auth.auth().currentUser{
                self.user = currentUser
            }
        }
    }
    
    
    //TODO: CREATE USER METHOD
    func createUser(email: String, password: String, username: String) async throws {
        do {
            // Firebase Authentication üzerinde kullanıcı oluştur
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            try await authResult.user.sendEmailVerification()
            try await createUserCollection(authResult: authResult, email: email, password: password, username: username)
        } catch let error as NSError{
                print("Auth Hata Kodu: \(error.code)")
                print("Auth Hata : \(error)")
                throw error
        }
    }

    //TODO: CREATE USER COLLECTİON FİELD 
    func createUserCollection(authResult : AuthDataResult,email: String, password: String, username: String) async throws{
        do{
            self.user = authResult.user
            let uid = authResult.user.uid
            let userCollection = Firestore.firestore().collection("user")
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
            ])
        }
    }
    
    //TODO: SIGN IN METHOD
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("burada")
            if result.user.isEmailVerified {
                // Kullanıcının e-posta adresi doğrulanmış
                self.user = result.user
                print("Kullanıcının e-posta adresi doğrulandı.")
            } else {
                print("Kullanıcının e-posta adresi henüz doğrulanmamış.")
                 let verifiedError = NSError(domain: "com.HaBu", code: 10, userInfo: [NSLocalizedDescriptionKey: "Giriş yapmak için önce mailinizi doğrulayınız."])
                throw verifiedError
            }
        } catch let error as NSError {
            print("Auth Hata Kodu: \(error.code)")
            print("Auth Hata : \(error)")
            throw error
        }
    }
    
    
    //TODO: LOGOUT METHOD
    func logOut() async throws -> Void{
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Auth Hata : \(error)")
        }
    }
    
    
    //TODO: FORGOT PASSWORD METHOD
    func forgotPassword(email: String) async throws -> Void {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch let error as NSError {
            print("Auth Hata Kodu: \(error.code)")
            print("Auth Hata : \(error)")
            throw error
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
 
    
 
    

}
