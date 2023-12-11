//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildFirstView: View {
    @EnvironmentObject var navigation:NavigationStateManager
    var body: some View {
        ZStack {
            VStack{
                Buttons.backButton {
                    navigation.pop()
                }
                .padding(.trailing,Const.width * 0.9)
                
                CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.RegisterSecondVector)
                VStack{
                    TextFields.CustomTextField(icon: .mail, placeHolder: "e-posta")
                    TextFields.CustomTextField(icon: .key, placeHolder: "Şifre")
                    TextFields.CustomTextField(icon: .key, placeHolder: "Şifre Tekrar")
                    
                    Buttons.customButton1(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                        navigation.push(.auth(.register(.second)))
                    }, size: .small, textColor: .white)
                    
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                    .background(
                        RectangleBlur(color: Const.primaryColor))
                HStack{
                    Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                    
                    Button(action: {
                        navigation.push(.auth(.loginView))
                    }, label: {
                        Text("Giriş Yap").foregroundStyle(.blue).fontWeight(.bold)
                    })
                    
                }}.frame(width: Const.width , height: Const.height+100)
        }.background(
            Const.authBackGroundColor
        )
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    RegisterBuildFirstView()
}
