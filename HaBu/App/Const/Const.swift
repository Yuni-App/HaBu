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
    static let primaryBackGroundColor = Color(UIColor(hex: "F3F3F3"))
    static let primaryButtonColor = Color(UIColor(hex: "04243E"))
    
    
    
    
    static let categoryTags: [String] = ["İtiraf","Satılık","Ev","Yardımlaşma","Arkadaşlık","Ders","İş","Kavga","Kitap","Ömer","Mert","Yusuf"]
    static var anonimFilters: [anonimFilter]=[
        .init(id: 0, color: .blue, title: "Hepsi", subTitle: "Bütün Gönderiler ", icon: "anonim"),
        .init(id: 1, color:.blue, title: "Anonim", subTitle: "Sadece Anonim Gönderiler", icon: "anonim"),
        .init(id: 2, color: .blue, title: "Normal", subTitle: "Sadece Normal Gönderiler", icon: "nonAnonim")
    ]
    static let agreement: String = "**Gizlilik Sözleşmesi**Bu gizlilik sözleşmesi, [Şirket Adı] tarafından sunulan hizmetlerin kullanımı sırasında toplanan bilgilerin nasıl işlendiğini ve korunduğunu açıklar. **Toplanan Bilgiler**- Kişisel Bilgiler: Ad, soyadı, e-posta adresi gibi kullanıcıya ait kişisel bilgiler.- Kullanım Bilgileri: Web sitesi veya uygulamayı nasıl kullandığınıza dair bilgiler.**Bilgi Kullanımı**Toplanan bilgiler, aşağıdaki amaçlar için kullanılabilir:- Hizmet sağlamak ve yönetmek.- Kullanıcı deneyimini kişiselleştirmek.- Güvenlik amacıyla bilgileri izlemek.- İstatistiksel analizler yapmak.**Bilgi Paylaşımı**Şirketiniz, kullanıcı bilgilerini üçüncü taraflarla paylaşmayacak veya satmayacaktır. Ancak, yasal zorunluluk durumlarında gerekli bilgiler yetkililere sağlanabilir.**Güvenlik**Şirketiniz, toplanan bilgileri güvenli bir şekilde saklamak için çeşitli güvenlik önlemleri alır. Ancak, internet üzerinden iletişim kesin güvenli değildir.**Çocukların Gizliliği**Bu hizmet, 13 yaşın altındaki çocuklardan bilgi toplamaz bilir veya izin vermez. Eğer 13 yaşın altındaki bir çocuksanız, bu hizmeti kullanmamalısınız. **Değişiklikler**Bu gizlilik politikası zaman zaman güncellenebilir. Güncellemeler hakkında bilgilendirilmek için bu sayfayı düzenli olarak kontroetmelisiniz.Bu gizlilik sözleşmesini kabul etmek, [Şirket Adı] tarafından belirtilen koşulları anladığınız ve kabul ettiğiniz anlamına gelir."
}

