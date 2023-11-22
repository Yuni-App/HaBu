//
//  IconManager.swift
//  HaBu
//
//  Created by mert alp on 22.11.2023.
//

import Foundation
import SwiftUI

enum AppIcon: String, CaseIterable {
    case mail = "mail"

    //ikonlar buraya eklenmeli
    var systemName: String {
        return "systemName: \(rawValue)"
    }
}

class IconManager {
    static let shared = IconManager()
    
    private init() {}
    func getIcon(_ icon: AppIcon, size: CGFloat = 24, weight: Font.Weight = .regular, color: Color = .primary) -> some View {
        return Image(systemName: "mail")
            .resizable()
            .frame(width: size, height: size)
            .font(Font.system(size: size, weight: weight))
            .foregroundColor(color)
    }
}
//kullanımı
// enum yapısına iconunuzu ekleyin
//view içinde IconManager.shared.getIcon(.mail, size: 50, weight: .bold, color: .blue)
//şeklinde kullanaiblirsiniz
//icon zorunludur diğer seçenekler opsiyoneldir
