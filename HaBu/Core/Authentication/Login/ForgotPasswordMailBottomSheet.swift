//
//  showingForgotPassword.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordMailBottomSheet: View {

    var body: some View {
        NavigationStack{
            VStack{
                Text("Lütfen mail adresinizi giriniz.").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
            CustomTextField(icon: "mail", placeHolder: "email")
                CustomButton(title: "Onay Kodu Gönder", backgroundColor: Const.primaryColor, action: {
                    //mail check
                    LoginView()
                })
          
            }.padding(30)
                .frame(width: Const.width , height:  Const.height)
                .background(
                    BackgroundLinearColor()
                )
        }
    }
}

#Preview {
    ForgotPasswordMailBottomSheet()
}
