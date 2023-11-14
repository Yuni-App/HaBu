//
//  InfoView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("HaBu!").foregroundStyle(Const.primaryColor).font(.custom("IrishGrover-Regular", size: 35))
                CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                    print("login button")
                }, destinaiton: AnyView(LoginView()))
                
                CustomButton(title: "Kayıt Ol", backgroundColor:Const.secondaryColor, action: {
                    print("register view")
                }, destinaiton: AnyView(RegisterBuildFirstView()))
                
            }
        }
        
        
    }
}

#Preview {
    InfoView()
}
