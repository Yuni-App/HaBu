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
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.registerThirdVector)
                    
                    VStack{
                        CustomImage(width: Const.width * 0.6, height: Const.height * 0.1, imagePath: ImageManager.habuLogo)
                        CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                            true
                        }, destination: AnyView(LoginView()), size: CustomButtonSize.small).padding()
                        
                        CustomButton(title: "Kayıt Ol", backgroundColor: Const.secondaryColor, action: {
                            true
                        },destination: AnyView(RegisterBuildFirstView()),size: CustomButtonSize.small , textColor: .black)
                        
                    }.frame(width: Const.width*0.85,height: Const.height * 0.35)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                }
                .frame(width: Const.width , height: Const.height)
                .padding()
            }.background(
                BackgroundLinearColor()
            )
            
            
        }
        
        
        
    }
}
#Preview {
    InfoView()
}
