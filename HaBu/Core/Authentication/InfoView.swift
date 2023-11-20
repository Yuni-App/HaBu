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
                        CustomImageRectangle(width: Const.width, height: Const.height/2, imagePath: ImageManager.registerThirdVector)
                        ZStack{
                            Image("")
                                .frame(width: 330, height: 250)
                                .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                            VStack{
                                CustomImageRectangle(width: 330, height: 90, imagePath: ImageManager.habuLogo)
                                CustomLinkButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                                    print("login button")
                                }, destinaiton: AnyView(LoginView()), size: CustomButtonSize.small)
                                CustomLinkButton(title: "Kayıt Ol", backgroundColor: Const.secondaryColor, action: {
                                    print("register view")
                                },destinaiton: AnyView(RegisterBuildFirstView()),size: CustomButtonSize.small , textColor: .black)
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
