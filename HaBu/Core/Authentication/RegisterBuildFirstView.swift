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
                    CustomImageRectangle(width: 537, height: 376, imagePath: ImageManager.registerVector)
                    CustomTextField(icon: "envelope", placeHolder: "e-posta")
                    CustomTextField(icon: "key", placeHolder: "Şifre")
                    CustomTextField(icon: "key", placeHolder: "Şifre Tekrar")
                    HStack{
                        Spacer()
                        CustomButton(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                        }, destinaiton: AnyView(RegisterBuildSecondView()), width: Const.width/3)
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
    RegisterBuildFirstView()
}
