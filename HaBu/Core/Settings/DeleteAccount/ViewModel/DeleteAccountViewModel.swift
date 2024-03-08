//
//  DeleteAccountViewModal.swift
//  HaBu
//
//  Created by mert alp on 22.12.2023.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

class DeleteAccountViewModel: ObservableObject {
    @Published var textPassword: String = ""
    @Published var verificationCode: String = ""
    @Published var alertMessage: String? = nil
    @Published var alertTitle: String? = nil
    @Published var showingAlert = false
    
    
    func deleteAccount(completion: @escaping (Bool, Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            // Kullanıcı oturum açmamış veya kullanılamamıyor hatasını ele al
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: textPassword)
        
        user.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                completion(false, error)
                self.alertTitle = "Hata!"
                self.alertMessage = "Yanlış şifre girdiniz."
                self.showingAlert = true
                return
            } else {
                user.delete { error in
                    if let error = error {
                        completion(false, error)
                        self.alertTitle = "Hata!"
                        self.alertMessage = "Hesap silme işlemi başarısız."
                        self.showingAlert = true
                        return
                    } else {
                        completion(true, nil)
                        self.alertTitle = "Uyarı!"
                        self.alertMessage = "Hesabınız kalıcı olarak silenecektir."
                        self.showingAlert = true
                        return
                    }
                }
            }
        }
    }
}

