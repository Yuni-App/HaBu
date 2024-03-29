//
//  CustomAlertView.swift
//  HaBu
//
//  Created by mert alp on 7.02.2024.
//

import SwiftUI
struct CustomAlert {
    static func make(for alertType: AlertType, addPostVM: AddPostViewModel) -> Alert {
        switch alertType {
        case .anonymous:
            return Alert(
                title: Text("Profil Görünümü"),
                primaryButton: .default(
                    Text("Anonim"),
                    action: {
                        addPostVM.isAnonimType = .anonymous
                        print("Anonim seçildi.")
                    }
                ),
                secondaryButton: .default(
                    Text("Gerçek"),
                    action: {
                        addPostVM.isAnonimType = .notAnonymous
                        print("Profili Göster seçildi.")
                    }
                )
            )
        case .approval:
            return Alert(
                title: Text("Gönderi Oluşturuluyor"),
                primaryButton: .default(
                    Text("Onayla"),
                    action: {
                        addPostVM.isShare = true
                        Task {
                            await addPostVM.createPost()
                        }
                    }
                ),
                secondaryButton: .cancel(
                    Text("İptal"),
                    action: {
                        addPostVM.isShare = false
                    }
                )
            )
        case .errorAlert:
            return Alert(
                title: Text(addPostVM.alertTitle),
                message: Text(addPostVM.alertMessage),
                dismissButton: .default(Text("Tamam"))
            )
        default:
            return Alert(
                title: Text("Hata!!"),
                message: Text("Beklenmedik Bir Hata Oluştu. Tekrar Deneyin.."),
                dismissButton: .default(Text("Tamam"))
            )
        }
    }
}
