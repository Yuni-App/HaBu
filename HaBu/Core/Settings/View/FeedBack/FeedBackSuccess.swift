//
//  FeedBackSuccess.swift
//  HaBu
//
//  Created by yusuf on 6.12.2023.
//

import SwiftUI

struct FeedBackSuccess: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    Spacer()
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: Const.width * 0.55, height: Const.height * 0.25)
                    .background(Color(red: 0.02, green: 0.14, blue: 0.24).opacity(0.18))
                    .cornerRadius(112)
                    .overlay {
                        Image("dua")
                    }
                    
                    Text("DEĞERLİ GERİ BİLDİRİMİZ İÇİN TEŞEKKÜR EDERİZ ..")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0, green: 0.38, blue: 0.17))
                    .frame(width: Const.width * 1, height: Const.height * 0.2, alignment: .center)
                    
                    Text("Merhaba HaBu Kullanıcısı,\nDeğerli düşünceleriniz ve önerileriniz, uygulamamızı daha da geliştirmemize katkı sağlıyor. Sizin gibi değerli kullanıcılarımızın memnuniyeti, en önemli önceliğimizdir. HaBu'yu tercih ettiğiniz için teşekkür ederiz. İyi günler dileriz!\nSaygılarımla, HaBu Ekibi")
                      .font(
                        Font.custom("Inter", size: 17)
                          .weight(.bold)
                      )
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color.black.opacity(0.7))
                      .frame(width: Const.width * 0.7, alignment: .center)
                    
                    Spacer()
                    NavigationLink(destination: TabbarView().navigationBarBackButtonHidden()) {
                        Text("Ana Sayfaya Dön").fontWeight(.semibold)
                            .frame(width: Const.width * 0.5, height: Const.height * 0.05, alignment: .center)
                            .foregroundColor(.white)
                            .background(Const.primaryButtonColor)
                            .cornerRadius(8)
                            
                    }
                    
                }
            }
        }
    }
}


#Preview {
    FeedBackSuccess()
}
