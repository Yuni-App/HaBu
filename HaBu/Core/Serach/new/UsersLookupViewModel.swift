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
        db.collection("user").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else {
                print("No documents")
                return
            }
            self.queryResultUsers = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
}
