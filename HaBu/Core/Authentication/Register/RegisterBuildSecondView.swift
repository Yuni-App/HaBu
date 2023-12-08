//
//  RegisterBuildSecondView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildSecondView: View {
    var body: some View {
            ZStack {
                VStack{
                    CustomImage(width: Const.width, height: Const.height * 0.3, imagePath: ImageManager.registerVector)
                        VStack{
                            TextFields.CustomTextField(icon: .blocked, placeHolder: "Ad")
                            TextFields.CustomTextField(icon: .blocked, placeHolder: "Soy Ad")
                            TextFields.CustomTextField(icon: .blocked, placeHolder: "Kullanıcı Adı")
                            TextFields.CustomTextField(icon: .blocked, placeHolder: "Yaş")
                            TextFields.CustomTextField(icon: .blocked, placeHolder: "Bio")
                            CustomButton(title: "Devam Et", backgroundColor: Const.primaryColor, action: {true}, destination: AnyView(RegisterBuildThirdView()), size: CustomButtonSize.small)
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.5)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                        
                    HStack{
                        Text("Bir hesabınız var mı?")
                            .foregroundStyle(.black)
                            .font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{  Text("Giriş Yap")
                                .foregroundStyle(.blue)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                    }}.frame(width: Const.width , height: Const.height+100)
                    .padding()
    
            }
            .background(
                Const.authBackGroundColor
            )
    }
}

#Preview {
    RegisterBuildSecondView()
}
