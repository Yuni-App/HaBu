//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildFirstView: View {
    @Environment(\.dismiss) var dissmis


    @State private var textEmail : String = ""
    @State private var textPassword : String = ""
    @State private var textPasswordAgain : String = ""
    var body: some View {
        ZStack {
            VStack{
                Buttons.backButton {
                    dissmis()
                }
                .padding(.trailing,Const.width * 0.9)
                
                CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.RegisterSecondVector)
                VStack{
                    TextFields.CustomTextField(text: $textEmail, icon: .mail, placeHolder: "e-posta")
                    TextFields.CustomTextField(text :$textPassword ,icon: .key, placeHolder: "Şifre")
                    TextFields.CustomTextField(text : $textPasswordAgain , icon: .key, placeHolder: "Şifre Tekrar")
                    
                    Buttons.customButton1(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                    }, size: .small, textColor: .white, destination: AnyView(RegisterBuildSecondView()))
                    
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                    .modifier(RectangleBlurModifier(color: Const.primaryColor))
                HStack{
                    Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Giriş Yap").foregroundStyle(.blue).fontWeight(.bold)

                    }

                    
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
