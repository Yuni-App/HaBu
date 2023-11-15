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
            VStack{
                CustomTextField(icon: "mail", placeHolder: "e-posta")
                CustomTextField(icon: "key", placeHolder: "Şifre")
                CustomTextField(icon: "key", placeHolder: "Şifre Tekrar")
                
                CustomButton(title: "Kayıt Ol", backgroundColor: Const.primaryColor, action: {
                    //will delete the back button from feedview
                    print("  login button")
                }, destinaiton: AnyView(FeedView()))
                
            }.padding(30)
        }    }
}

#Preview {
    RegisterBuildSecondView()
}
