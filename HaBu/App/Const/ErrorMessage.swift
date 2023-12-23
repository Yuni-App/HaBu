//
//  ErrorMessage.swift
//  HaBu
//
//  Created by mert alp on 21.12.2023.
//

import Foundation

enum ErrorMessage: Int  {
    case emptyFields = 1
    case invalidEmail = 2
    case wrongPassword = 17009
    case userNotFound = 4
    case authenticationError = 5
    
    var description: String {
        switch self {
        case .emptyFields:
            return "E-posta ve şifre alanları boş bırakılamaz."
        case .invalidEmail:
            return "Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin."
        case .wrongPassword:
            return "Yanlış şifre. Lütfen doğru şifreyi girin."
        case .userNotFound:
            return "Kullanıcı bulunamadı. Lütfen kayıtlı bir e-posta adresi kullanın veya hesap oluşturun."
        case .authenticationError:
            return "Kimlik doğrulama hatası. Lütfen tekrar deneyin."
        }
    }
}
