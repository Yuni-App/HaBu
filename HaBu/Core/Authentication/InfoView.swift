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
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 330, height: 390)
                            .background(
                                Image(ImageManager.infoVector)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                            )
                        ZStack{
                            Image("")
                                .frame(width: 330, height: 250)
                                .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.09))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.9), radius: 10, x: 10, y: 5)

                            VStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 330, height: 90)
                                    .background(
                                        Image(ImageManager.habuLogo)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.white)
                                    )
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
            LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.51, green: 0.93, blue: 0.9), location: 0.00),
            Gradient.Stop(color: Color(red: 0.13, green: 0.28, blue: 0.34), location: 0.48),
            Gradient.Stop(color: Color(red: 0, green: 0, blue: 0.50).opacity(0.5), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
            )
        )
        }
    }
}

#Preview {
    InfoView()
}
