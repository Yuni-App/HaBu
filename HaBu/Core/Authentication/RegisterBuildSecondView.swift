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
                    CustomImageRectangle(width: 537, height: 376, imagePath: ImageManager.registerVector)

                    CustomTextField(icon: "person.fill", placeHolder: "Ad")
                    CustomTextField(icon: "person.fill", placeHolder: "Soy Ad")
                    CustomTextField(icon: "person.badge.plus", placeHolder: "Kullanıcı Adı")
                    CustomTextField(icon: "calendar", placeHolder: "Yaş")
                    CustomTextField(icon: "pencil", placeHolder: "Bio")
                    HStack{
                        Spacer()
                        CustomButton(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                        }, destinaiton: AnyView(RegisterBuildThirdView()), width: Const.width/3)
                    }
                    Spacer()
                    HStack{
                        Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{  Text("Giriş Yap").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                }}.padding(30)
                    .frame(width: 430, height: 932)
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
