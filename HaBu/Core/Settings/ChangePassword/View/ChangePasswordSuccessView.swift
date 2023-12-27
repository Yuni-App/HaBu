//
//  ChangePasswordSuccessView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct ChangePasswordSuccessView: View {
    @State private var isActiveDestination: Bool = false
    var body: some View {
        VStack{
            Spacer()
            VStack{
                CustomImage(width: Const.width, height: Const.height * 0.25, imagePath: ImageManager.success)
                Text("ŞİFRENİZ BAŞARIYLA GÜNCELLENMİŞTİR...").frame(width: Const.width * 0.5).foregroundColor(.green).fontWeight(.bold)
            }
            Spacer()
            Buttons.customButton(title:"Ana Sayfaya Dön" , buttonColor: Const.primaryButtonColor) {
                isActiveDestination = true
            }
            
        }.frame(width: Const.width)
            .background(Const.primaryBackGroundColor
            ).navigationDestination(isPresented: $isActiveDestination, destination: {
                TabbarView()
            })
            .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ChangePasswordSuccessView()
}
