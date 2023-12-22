//
//  FeedBackSuccess.swift
//  HaBu
//
//  Created by yusuf on 6.12.2023.
//

import SwiftUI

struct FeedBackSuccess: View {
    @State private var isPopupVisible = false
    var body: some View {
        NavigationView{
            ZStack {
                ScrollView{
                    HStack {
                        Buttons.backButton(action: {
                            //
                        }).padding()
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width * 0.55, height: Const.height * 0.25)
                            .background(Color.gray.opacity(0.35))
                            .cornerRadius(112)
                            .overlay {
                                Image("dua").resizable()
                            }
                        
                        Text("DEĞERLİ GERİ BİLDİRİMİZ İÇİN TEŞEKKÜR EDERİZ ..")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.38, blue: 0.17))
                            .frame(alignment: .center).padding()
                        
                        Text(Const.feedBackText)
                            .font(
                                Font.custom("Inter", size: 17)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.black.opacity(0.7))
                            .frame(width: Const.width * 0.7, alignment: .center)
                            .padding()
                        NavigationLink(destination: TabbarView().navigationBarBackButtonHidden(true),label: {
                            Text("Ana Sayfaya Dön").fontWeight(.semibold)
                                .frame(width: Const.width * 0.5, height: Const.height * 0.05, alignment: .center)
                                .foregroundColor(.white)
                                .background(Const.primaryButtonColor)
                                .cornerRadius(8)
                            
                        }
                        ).padding()
                    }
//                   Button("Show Popup") {
//                      isPopupVisible.toggle()
//                   }
                }
           }
//     .popup(isPresented: $isPopupVisible) {
//    PopUps.LoginPopup(size: .xsmall, contents: "Bu kullanıcı adı daha önce alındı başka bir kullanıcı //adı ile tekrar deneyiniz", okeybtn: $isPopupVisible)
//            }
        }
    }
}


#Preview {
    FeedBackSuccess()
}
