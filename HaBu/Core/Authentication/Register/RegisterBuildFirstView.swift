//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildFirstView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.RegisterSecondVector)
                        VStack{
                            CustomTextField(icon: "envelope", placeHolder: "e-posta")
                            CustomTextField(icon: "key", placeHolder: "Şifre")
                            CustomTextField(icon: "key", placeHolder: "Şifre Tekrar")
                            CustomButton(title: "Devam Et", backgroundColor: Const.primaryColor, action: {true}, destination: AnyView(RegisterBuildSecondView()), size: CustomButtonSize.small)
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .background(RectangleBlur(color: Const.primaryColor))
                                        HStack{
                        Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{Text("Giriş Yap").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                }}.frame(width: Const.width , height: Const.height+100)
            }.background(
                BackgroundLinearColor()
            )
            
        }
    }
}

#Preview {
    RegisterBuildFirstView()
}
