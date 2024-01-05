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
    @Published var currentUser : User?
    //TODO: USER CHECK
    func checkUser() async throws {
        do {
            if let currentUser = Auth.auth().currentUser{
                AuthService.shared.user = currentUser
                AuthService.shared.currentUser = try await UserService.fetchUser(withUserID: "HpPAPu9PVbeerPevBzq0LFPKU6P2")
              
            }
        }
        catch{
            print(error)
        }
    }
    
    
    //TODO: CREATE USER METHOD
    func createUser(email: String, password: String, username: String) async throws {
        do {
            // Firebase Authentication üzerinde kullanıcı oluştur
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            try await authResult.user.sendEmailVerification()
            print("sdfgfsfdsdff")

            try await createUserCollection(authResult: authResult, email: email, password: password, username: username)
        } catch let error as NSError{
                print("Auth Hata Kodu: \(error.code)")
                print("Auth Hata : \(error)")
                throw error
        }
    }

    //TODO: CREATE USER COLLECTİON FİELD 
    @MainActor
    func createUserCollection(authResult : AuthDataResult,email: String, password: String, username: String) async throws{
        do{
            
          
         
            let uid = authResult.user.uid
            let userCollection = Firestore.firestore().collection("user")
            
            try await userCollection.document(uid).setData([
                "id": uid,
                "email": email,
                "created_at":"",
                "username": username,
                "name":"",
                "surname": "",
                "password": password,
                "register_year": "",
                "rating": 0.0,
                "department":""
            ])
            try Auth.auth().signOut()
            AuthService.shared.user = nil
         
        }
    }
    
    //TODO: SIGN IN METHOD
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("burada")
            if result.user.isEmailVerified {
                // Kullanıcının e-posta adresi doğrulanmış
        
                AuthService.shared.user = result.user
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
            AuthService.shared.user = nil
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
