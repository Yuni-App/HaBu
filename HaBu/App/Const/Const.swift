//
//  Const.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import Foundation
import SwiftUI
class Const{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let primaryColor  = Color(uiColor: UIColor(hex: "55BCB6"))
    static let primaryUiColor = UIColor(hex: "55BCB6")
    static let thirColor = Color(uiColor: UIColor(hex: "5B8291"))
    static let secondaryColor = Color(uiColor : UIColor(hex:"68E4DD"))
    static let categoryTags: [String] = ["İtiraf","Satılık","Ev","Yardımlaşma","Arkadaşlık","Ders","İş","Kavga","Kitap","Ömer","Mert","Yusuf"]
    static var anonimFilters: [anonimFilter]=[
        .init(id: 0, color: Const.thirColor, title: "Hepsi", subTitle: "Bütün Gönderiler ", icon: "anonim"),
        .init(id: 1, color: Const.thirColor, title: "Anonim", subTitle: "Sadece Anonim Gönderiler", icon: "anonim"),
        .init(id: 2, color: Const.thirColor, title: "Normal", subTitle: "Sadece Normal Gönderiler", icon: "nonAnonim")
    ]

}

