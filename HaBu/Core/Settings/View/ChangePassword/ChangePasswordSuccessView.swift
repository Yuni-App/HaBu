//
//  ChangePasswordSuccessView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct ChangePasswordSuccessView: View {
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                CustomImage(width: Const.width, height: Const.height * 0.25, imagePath: ImageManager.success)
                Text("ŞİFRENİZ BAŞARIYLA GÜNCELLENMİŞTİR...").frame(width: Const.width * 0.5).foregroundColor(.green).fontWeight(.bold)
            }
            Spacer()
            CustomButton(title: "Ana Sayfaya Dön", backgroundColor: Const.primaryButtonColor, action: {
                true
            }, destination: AnyView(TabbarView().navigationBarBackButtonHidden(true)), size: CustomButtonSize.medium)
        }.frame(width: Const.width)
            .background(Const.primaryBackGroundColor
        )
            .navigationBarBackButtonHidden(true)
     
    }
}

#Preview {
    ChangePasswordSuccessView()
}
