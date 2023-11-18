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
                    CustomImageRectangle(width: Const.width, height: Const.height/3, imagePath: ImageManager.RegisterSecondVector)
                    ZStack{
                        Image("")
                            .frame(width: 370, height: 330)
                            .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                        VStack{
                            CustomTextField(icon: "envelope", placeHolder: "e-posta")
                            CustomTextField(icon: "key", placeHolder: "Şifre")
                            CustomTextField(icon: "key", placeHolder: "Şifre Tekrar")
                            CustomLinkButton(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                            }, destinaiton: AnyView(RegisterBuildSecondView())).padding(.top , 50)
                     
                        }
                    }
                    HStack{
                        Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{Text("Giriş Yap").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                }.padding(.top , 50)}.padding(.horizontal , 20)
                    .frame(width: 430, height: 932)
                    .background(
                        BackgroundLinearColor()
                    )
            }
            
        }
    }
}

#Preview {
    RegisterBuildFirstView()
}
