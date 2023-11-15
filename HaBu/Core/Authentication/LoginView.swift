//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {

    var body: some View {
        
        NavigationStack{
            VStack{
                CustomTextField(icon: "mail", placeHolder: "e-posta")
                CustomTextField(icon: "key", placeHolder: "Şifre")
                CustomTextField(icon: "key", placeHolder: "Şifre Tekrar")
                
                CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                    print("cliked login button")
                }, destinaiton: AnyView(FeedView()))
                
            }.padding(30)
        }     //will delete the back button from feedview
    }
}

#Preview {
    LoginView()
}


