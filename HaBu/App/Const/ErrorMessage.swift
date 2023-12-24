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
    case shortPassword = 3
    case passwordsNotMatch = 4
    case wrongPassword = 17004
    case confidentialityAgreement = 5
    
    
    var description: String {
        switch self {
        case .emptyFields:
            return "Lütfen tüm alanları doldurunuz. "
        case .invalidEmail:
            return "Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin."
        case .shortPassword:
             return "Şifre en az 6 karakterli olmalı "
        case .wrongPassword:
            return "Yanlış şifre. Lütfen doğru şifreyi girin."
        case .passwordsNotMatch:
            return "Şifreler Eşleşmiyor"
        case .confidentialityAgreement:
            return "Gizlilik sözleşmesini onaylanıyız"
        }
    }
}
