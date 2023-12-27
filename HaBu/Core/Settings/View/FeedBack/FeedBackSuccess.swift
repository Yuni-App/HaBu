//
//  FeedBackSuccess.swift
//  HaBu
//
//  Created by yusuf on 6.12.2023.
//

import SwiftUI

struct FeedBackSuccess: View {
    @State private var isActiveDestination: Bool = false
    var body: some View {
                ScrollView{
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
                        Buttons.GecilecekOlancustomButton(title: "Ana Sayfaya Dön", buttonColor: Const.primaryButtonColor) {
                            isActiveDestination = true
                        }.padding(.top , 80)
                      
                    }.navigationDestination(isPresented: $isActiveDestination, destination: {
                        TabbarView()
                    })
                    .navigationBarBackButtonHidden()
           }
        }
    
}


#Preview {
    FeedBackSuccess()
}
