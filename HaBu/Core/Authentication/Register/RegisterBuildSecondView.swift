//
//  RegisterBuildSecondView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildSecondView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    CustomImageRectangle(width: Const.width, height: Const.height/3, imagePath: ImageManager.registerVector)
                    ZStack{
                        Image("")
                            .frame(width: 370, height: 470)
                            .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                        VStack{
                            CustomTextField(icon: "person.fill", placeHolder: "Ad")
                            CustomTextField(icon: "person.fill", placeHolder: "Soy Ad")
                            CustomTextField(icon: "person.badge.plus", placeHolder: "Kullanıcı Adı")
                            CustomTextField(icon: "calendar", placeHolder: "Yaş")
                            CustomTextField(icon: "pencil", placeHolder: "Bio")
                            CustomLinkButton(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                            }, destinaiton: AnyView(RegisterBuildThirdView()), size: CustomButtonSize.small)
                            .padding(.top,50)
                        }
                    }
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
                    }.padding(30)}
                    .padding(.horizontal , 20)
                    .frame(width: 430, height: 1000)
                    .background(
                        BackgroundLinearColor()
                    )
            }
        }
    }
}

#Preview {
    RegisterBuildSecondView()
}
