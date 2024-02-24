//
//  FeedBackViewModel.swift
//  HaBu
//
//  Created by yusuf on 24.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct FeedbackModel {
      let text: String
      let rating: Int
}

let db = Firestore.firestore()

class FeedBackInputViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedRating: Int = 0
    @Published var isSubmittingFeedback: Bool = false
    @Published var feedbackSubmitted: Bool = false
    
    func submitFeedback() {
        guard !text.isEmpty else {
            // Handle empty text case, e.g., display an alert
            return
        }
        
        isSubmittingFeedback = true
        
        let feedbackData: [String: Any] = [
            "text": text,
            "rating": selectedRating,
            "timestamp": Timestamp(date: Date())
        ]
        
        db.collection("feedback").addDocument(data: feedbackData) { error in
            self.isSubmittingFeedback = false
            
            if let error = error {
                // Handle error
            } else {
                self.feedbackSubmitted = true
                // Do something after feedback is submitted, e.g., navigate back
            }
        }
    }

}
