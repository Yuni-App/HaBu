//
//  UserService.swift
//  HaBu
//
//  Created by OmerErbalta on 19.12.2023.
//

import Foundation
import FirebaseFirestore
protocol UserProvider{
   static func fetchUser(withUserID userID: String) async throws -> User
   static func fetchAllUsers() async throws ->  [User]
}
struct UserService : UserProvider{
   
    static func fetchUser(withUserID userID: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("user").document(userID).getDocument()
        return try snapshot.data(as: User.self)
    }
    
   static func fetchAllUsers() async throws -> [User]{
      let snapshot = try await  Firestore.firestore().collection("user").getDocuments()
       return snapshot.documents.compactMap({try? $0.data(as:User.self)})
    }
}
