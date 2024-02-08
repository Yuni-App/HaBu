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
    let db = Firestore.firestore()
   

    //TODO: USER CHECK
    func checkUser() async throws {
        do {
            if let currentUser = Auth.auth().currentUser{
                AuthService.shared.user = currentUser
                AuthService.shared.currentUser = try await UserService.fetchUser(withUserID: currentUser.uid)
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
    
    
    
   
    // Rastgele beş haneli bir ID oluşturma fonksiyonu
    func rastgeleBesHaneliIDOlustur() -> String {
        var id = ""
        for _ in 0..<5 {
            let rastgeleRakam = Int.random(in: 0...9)
            id += "\(rastgeleRakam)"
        }
        return id
    }

    // Kullanılan ID'leri kontrol etme ve anonim kullanıcıyı kaydetme fonksiyonu
   
    func kontrolEtVeKaydetAnonimKullanici(completion: @escaping (String) -> Void) async {
        // Rastgele beş haneli bir ID oluşturun
        let anonimID = rastgeleBesHaneliIDOlustur()
        
        // Kullanılan kimlikler koleksiyonunu referans al
        let kullanilanIDlerRef = db.collection("KullanılanIDler")
        
        do {
            // Oluşturulan rastgele ID'nin daha önce kullanılıp kullanılmadığını kontrol et
            let querySnapshot = try await kullanilanIDlerRef.whereField("ID", isEqualTo: anonimID).getDocuments()
            
            if querySnapshot.documents.isEmpty {
                // Bu ID daha önce kullanılmamış, kullanıcıyı kaydet
                print("Anonim kullanıcı başarıyla kaydedildi. ID: \(anonimID)")
                kullanilanIDlerRef.addDocument(data: ["ID": anonimID]) { (error) in
                    if let error = error {
                        print("Kullanılan ID'leri kaydetme işleminde bir hata oluştu: \(error.localizedDescription)")
                    }
                }
                completion(anonimID)
            } else {
                // Bu ID daha önce kullanılmış, yeni bir ID oluştur
                await kontrolEtVeKaydetAnonimKullanici(completion: completion)
            }
        } catch {
            print("Kullanılan ID'leri kontrol ederken bir hata oluştu: \(error.localizedDescription)")
        }
    }






    //TODO: CREATE USER COLLECTİON FİELD 
    @MainActor
    func createUserCollection(authResult : AuthDataResult,email: String, password: String, username: String) async throws{
        var anonimId2 : String = ""
        do{
            
          
         
            let uid = authResult.user.uid
            let userCollection = Firestore.firestore().collection("user")
      
            
            
            await kontrolEtVeKaydetAnonimKullanici { (anonimID) in
                print("Oluşturulan rastgele kimlik: \(anonimID)")
                anonimId2 = anonimID
                
            }
            try await userCollection.document(uid).setData([
                "id": uid,
                "anonimId":anonimId2,
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
