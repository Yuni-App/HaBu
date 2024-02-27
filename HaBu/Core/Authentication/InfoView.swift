//
//  InfoView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct InfoView: View {
    @State private var isActiveDestination: Bool = false
    @State var activeDestinaiton : AnyView?
    var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    VStack {
                        CustomImage(width: Const.width * 1, height: Const.height * 0.2, imagePath: ImageManager.habuLogo)
                        TextFields.CustomTitle(text: "KAMPÜSÜN GİZLİ", size: 30)
                        TextFields.CustomTitle(text: "DÜNYASI!", size: 30)
                    }
                    
                    Spacer()
                    VStack{
                        Buttons.customButton(title: "Giriş Yap", buttonColor: Const.whiteColor , textColor: .black) {
                            activeDestinaiton = AnyView(LoginView())
                            isActiveDestination = true
                        }.padding()
                        Buttons.customButton(title: "Kayıt Ol", buttonColor: Const.whiteColor , textColor: .black ) {
                            activeDestinaiton = AnyView(RegisterView())
                            isActiveDestination = true
                        }
                    }
                    Spacer()
                }
                .frame(width: Const.width , height: Const.height)
                .navigationDestination(isPresented: $isActiveDestination, destination: {
                    activeDestinaiton
                })
            }.navigationBarBackButtonHidden(true)
            .background(Const.primaryColor)
        
       
    
        
    }
}
#Preview {
    InfoView()
}
