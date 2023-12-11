//
//  RegisterBuildSecondView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildSecondView: View {
    @EnvironmentObject var navigation:NavigationStateManager
    @State private var textName  : String = ""
    @State private var textSurname : String = ""
    @State private var textUserName : String = ""
    @State private var textAge : String = ""
    @State private var textBio : String = ""

    var body: some View {
            ZStack {
                VStack{
                    Buttons.backButton {
                        navigation.pop()
                    }
                    .padding(.trailing,Const.width * 0.9)
                    CustomImage(width: Const.width, height: Const.height * 0.3, imagePath: ImageManager.registerVector)
                        VStack{
                            TextFields.CustomTextField(text: $textName, icon: .blocked, placeHolder: "Ad")
                            TextFields.CustomTextField(text: $textSurname, icon: .blocked, placeHolder: "Soy Ad")
                            TextFields.CustomTextField(text : $textUserName , icon: .blocked, placeHolder: "Kullanıcı Adı")
                            TextFields.CustomTextField(text: $textAge, icon: .blocked, placeHolder: "Yaş")
                            TextFields.CustomTextField(text: $textBio, icon: .blocked, placeHolder: "Bio")
                            
                            
                            Buttons.customButton1(title: "Devam Et", backgroundColor: Const.primaryColor, action: {
                                navigation.push(.auth(.register(.third)))
                            }, size: .small, textColor: .white)
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.5)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                        
                    HStack{
                        Text("Bir hesabınız var mı?")
                            .foregroundStyle(.black)
                            .font(.system(size: 14))
                        Button(action: {
                            navigation.push(.auth(.loginView))
                        }, label: {
                            Text("Giriş Yap").foregroundStyle(.blue).fontWeight(.bold)
                        })
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
