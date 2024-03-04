//
//  ChangePasswordViewModel.swift
//  HaBu
//
//  Created by mert alp on 22.12.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class ChangePasswordViewModel: ObservableObject {
    @Published var textPassword: String = ""
    @Published var textNewPassword: String = ""
    @Published var textNewPasswordAgain: String = ""
    @Published var alertMessage: String? = nil
    @Published var alertTitle: String? = nil
    @Published var showingAlert = false
    @Published var isActiveDestination: Bool = false
    
    func updatePassword() {
        guard let user = Auth.auth().currentUser else {
            // Kullanıcı oturum açmamış veya kullanılamamıyor hatasını ele al
            return
        }
        
        // Kullanıcının mevcut şifresini doğrulayın
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: textPassword)
        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                self.alertTitle = "Hata!"
                self.alertMessage = "Mevcut şifreniz yanlış."
                self.showingAlert = true
                return
            }
            
            // Yeni şifreleri kontrol edin
            guard self.textNewPassword.count >= 8 else {
                self.alertTitle = "Hata!"
                self.alertMessage = "Yeni şifreniz en az 8 karakter uzunluğunda olmalıdır."
                self.showingAlert = true
                return
            }
            
            guard self.textNewPassword == self.textNewPasswordAgain else {
                self.alertTitle = "Hata!"
                self.alertMessage = "Yeni şifreleriniz eşleşmiyor."
                self.showingAlert = true
                return
            }
            
            // Kullanıcının şifresini güncelleyin
            Auth.auth().currentUser?.updatePassword(to: self.textNewPassword) { error in
                if let error = error {
                    self.alertMessage = "Uygulamaya tekrar giriş yaparak deneyiniz lütfen."
                    self.showingAlert = true
                } else {
                    self.alertTitle = "Şifre Güncelleme"
                    self.alertMessage = "Başarılı bir şekilde şifreniz güncellendi. "
                    self.showingAlert = true
                   // self.isActiveDestination = true
                }
            }
        }
    }
}
