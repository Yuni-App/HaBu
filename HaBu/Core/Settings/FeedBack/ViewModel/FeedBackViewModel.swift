//
//  FeedBackViewModel.swift
//  HaBu
//
//  Created by yusuf on 24.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

struct FeedbackModel {
    let text: String
    let rating: Int
    let name : String
    let surname: String
}

let db = Firestore.firestore()

class FeedBackInputViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedRating: Int = 0
    @Published var isSubmittingFeedback: Bool = false
    @Published var feedbackSubmitted: Bool = false
    @State private var isActiveDestination: Bool = false
    
    func submitFeedback() {
        guard !text.isEmpty else {
            // gösterilecek hata mesajları
            return
        }
        
        // Check if user is authenticated
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        
        isSubmittingFeedback = true
        
        let feedbackData: [String: Any] = [
            "text": text,
            "rating": selectedRating,
            "timestamp": Timestamp(date: Date()),
            "UserId": currentUser.uid,
            
            
        ]
        
        db.collection("feedback").addDocument(data: feedbackData) { error in
            self.isSubmittingFeedback = false
            
            if let error = error {
                // Handle error
            } else {
                self.feedbackSubmitted = true
                self.isActiveDestination = true
                // Do something after feedback is submitted, e.g., navigate back
            }
        }
    }
    
}
