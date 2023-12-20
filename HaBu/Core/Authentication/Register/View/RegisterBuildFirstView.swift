//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildFirstView: View {
    @Environment(\.dismiss) var dissmis
    
    @StateObject var registerVM : RegisterViewModel
    init(){
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(authService: AuthService()))
    }

    var body: some View {
        ZStack {
            VStack{
                Buttons.backButton {
                    dissmis()
                }
                .padding(.trailing,Const.width * 0.9)
                
                CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.RegisterSecondVector)
                VStack{
                    TextFields.CustomTextField(text: $registerVM.textEmail, icon: .mail, placeHolder: "e-posta")
                    TextFields.CustomTextField(text :$registerVM.textPassword ,icon: .key, placeHolder: "Şifre")
                    TextFields.CustomTextField(text : $registerVM.textAgainPassword , icon: .key, placeHolder: "Şifre Tekrar")
                    
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
