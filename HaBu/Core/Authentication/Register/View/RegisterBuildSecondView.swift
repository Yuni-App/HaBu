//
//  RegisterBuildSecondView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildSecondView: View {
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
                    CustomImage(width: Const.width, height: Const.height * 0.3, imagePath: ImageManager.registerVector)
                        VStack{
                            TextFields.CustomTextField(text: $registerVM.textName, icon: .blocked, placeHolder: "Ad")
                            TextFields.CustomTextField(text: $registerVM.textSurname, icon: .blocked, placeHolder: "Soy Ad")
                            TextFields.CustomTextField(text : $registerVM.textUserName , icon: .blocked, placeHolder: "Kullanıcı Adı")
                            TextFields.CustomTextField(text: $registerVM.textAge, icon: .blocked, placeHolder: "Yaş")
                            TextFields.CustomTextField(text: $registerVM.textBio, icon: .blocked, placeHolder: "Bio")
                            Buttons.customButton1(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                            }, size: .small, textColor: .white, destination: AnyView(RegisterBuildThirdView()))
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.5)
                        .modifier(RectangleBlurModifier(color: Const.primaryColor))
                        
                    HStack{
                        Text("Bir hesabınız var mı?")
                            .foregroundStyle(.black)
                            .font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Giriş Yap").foregroundStyle(.blue).fontWeight(.bold)

                        }
                    }}.frame(width: Const.width , height: Const.height+100)
                    .padding()
    
            }
            .background(
                Const.authBackGroundColor
            )
            .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    RegisterBuildSecondView()
}
