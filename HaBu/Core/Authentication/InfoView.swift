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
        
        NavigationStack {
            ZStack {
                VStack {
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.registerThirdVector)
                    
                    VStack{
                        CustomImage(width: Const.width * 0.6, height: Const.height * 0.1, imagePath: ImageManager.habuLogo)
                        Buttons.GecilecekOlancustomButton(title: "Giriş Yap", buttonColor: Const.primaryColor , textColor: .white) {
                            activeDestinaiton = AnyView(LoginView())
                            isActiveDestination = true
                            
                        }.padding()
                        Buttons.GecilecekOlancustomButton(title: "Kayıt Ol", buttonColor: Const.secondaryColor , textColor: .black ) {
                            activeDestinaiton = AnyView(RegisterBuildFirstView())
                            isActiveDestination = true
    
                        }

                    }.frame(width: Const.width*0.85,height: Const.height * 0.35)
                        .modifier(RectangleBlurModifier(color: Const.primaryColor))
                }
                .frame(width: Const.width , height: Const.height)
                .padding()
                .navigationDestination(isPresented: $isActiveDestination, destination: {
                    activeDestinaiton
                })
            }
            .background(Const.authBackGroundColor)
        }
       
        .navigationBarBackButtonHidden(true)
        
    }
}
#Preview {
    ContentView()
}
