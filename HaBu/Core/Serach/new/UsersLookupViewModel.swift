//
//  UsersLookupViewModel.swift
//  HaBu
//
//  Created by mert alp on 18.03.2024.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UsersLookupViewModel: ObservableObject {
    @Published var queryResultUsers: [User] = []
    
    private let db = Firestore.firestore()
    
    func fetchUsers(with keyword: String) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID not available.")
            return
        }
        
        db.collection("user").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else {
                print("No documents")
                return
            }
            
            // Filtrelenmiş kullanıcıları saklamak için geçici bir dizi oluşturalım
            var filteredUsers: [User] = []
            
            // Query snapshot'taki her belgeyi işleyelim
            for document in documents {
                // Belgeden User objesini oluşturalım
                if let user = try? document.data(as: User.self) {
                    // Kullanıcı kimliği mevcut kullanıcı ile eşleşmiyorsa, listeye ekleyelim
                    if user.id != currentUserID {
                        filteredUsers.append(user)
                    }
                }
            }
            
            // Filtrelenmiş kullanıcıları atayalım
            self.queryResultUsers = filteredUsers
        }
    }
}
class UsersLookupViewModel: ObservableObject {
    @Published var queryResultUsers: [User] = []
    
    private let db = Firestore.firestore()
    
    func fetchUsers(with keyword: String) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID not available.")
            return
        }
        
        db.collection("user").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else {
                print("No documents")
                return
            }
            
            // Filtrelenmiş kullanıcıları saklamak için geçici bir dizi oluşturalım
            var filteredUsers: [User] = []
            
            // Query snapshot'taki her belgeyi işleyelim
            for document in documents {
                // Belgeden User objesini oluşturalım
                if let user = try? document.data(as: User.self) {
                    // Kullanıcı kimliği mevcut kullanıcı ile eşleşmiyorsa, listeye ekleyelim
                    if user.id != currentUserID {
                        filteredUsers.append(user)
                    }
                }
            }
            
            // Filtrelenmiş kullanıcıları atayalım
            self.queryResultUsers = filteredUsers
        }
    }
}
