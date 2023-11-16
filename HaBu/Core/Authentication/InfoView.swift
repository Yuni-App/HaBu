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
            ZStack {
                    VStack {
                        CustomImageRectangle(width: 330, height: 390, imagePath: ImageManager.infoVector)
                        ZStack{
                            Image("")
                                .frame(width: 330, height: 250)
                                .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.09))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.9), radius: 10, x: 10, y: 5)
                            VStack{
                                CustomImageRectangle(width: 330, height: 90, imagePath: ImageManager.habuLogo)
                                CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                                    print("login button")
                                }, destinaiton: AnyView(LoginView()))

                                CustomButton(title: "Kayıt Ol", backgroundColor: Const.secondaryColor, action: {
                                    print("register view")
                                }, destinaiton: AnyView(RegisterBuildFirstView()),textColor: .black)
                            }
                            
                        }
                    }
                    .padding()
                
            }
            .frame(width: 430, height: 932)
            .background(
            BackgroundLinearColor()
        )
        }
    }
}
#Preview {
    InfoView()
}
