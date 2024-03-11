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
    
    
    func transferAndDeleteUserData(completion: @escaping (Bool, Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            self.alertTitle = "Hata!"
            self.alertMessage = "Kullanıcı oturum açmamış veya kullanılamıyor."
            self.showingAlert = true
            return
        }
        
        let db = Firestore.firestore()
        let originalDocument = db.collection("user").document(user.uid)
        let backupDocument = db.collection("userArchive").document(user.uid)
        
        originalDocument.getDocument { (documentSnapshot, error) in
            if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                backupDocument.setData(documentSnapshot.data()!) { error in
                    if let error = error {
                        completion(false, error)
                        self.alertTitle = "Hata!"
                        self.alertMessage = "Veriler silinirken 1 hata oluştu."
                        self.showingAlert = true
                    } else {
                        originalDocument.delete() { error in
                            if let error = error {
                                completion(false, error)
                                self.alertTitle = "Hata!"
                                self.alertMessage = "Veriler silinirken bir hata oluştu."
                                self.showingAlert = true
                            } else {
                                completion(true, nil)
                            }
                        }
                    }
                }
            } else {
                completion(false, error ?? NSError(domain: "FirestoreError", code: -1, userInfo: nil))
                self.alertTitle = "Hata!"
                self.alertMessage = "Kullanıcı verileri bulunamadı."
                self.showingAlert = true
            }
        }
    }
    
    
    
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
                // Önce kullanıcı verilerini yedekle ve sil
                self.transferAndDeleteUserData { success, error in
                    if success {
                        // Kullanıcı verileri başarıyla yedeklendikten sonra kullanıcı hesabını sil
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
                                self.alertMessage = "Hesabınız silinmiştir."
                                self.showingAlert = true
                                return
                            }
                        }
                    } else {
                        completion(false, error)
                        self.alertTitle = "Hata!"
                        self.alertMessage = "Verilerin silinmesi sırasında bir hata oluştu."
                        self.showingAlert = true
                    }
                }
            }
        }
    }
}

