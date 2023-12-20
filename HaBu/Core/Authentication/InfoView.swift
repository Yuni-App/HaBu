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
                        
                        Buttons.customButton1(title: "Giriş Yap", backgroundColor: Const.primaryColor, action:{
                            
                            
                        }, size: .small, textColor: .white, destination: AnyView(LoginView()))
                        .padding()
                        
                        Buttons.customButton1(title: "Kayıt Ol", backgroundColor: Const.secondaryColor, action: {
                        }, size: .small, textColor: .black, destination: AnyView(RegisterBuildFirstView()))
                    }.frame(width: Const.width*0.85,height: Const.height * 0.35)
                        .modifier(RectangleBlurModifier(color: Const.primaryColor))
                }
                .frame(width: Const.width , height: Const.height)
                .padding()
            }
            .background(Const.authBackGroundColor)
        }
        
        .navigationBarBackButtonHidden(true)
        
    }
}
#Preview {
    ContentView()
}
