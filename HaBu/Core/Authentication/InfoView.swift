//
//  InfoView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct InfoView: View {
    @StateObject var navigation = NavigationStateManager()
    
    var body: some View {
        
        NavigationStack(path:$navigation.path ) {
            ZStack {
                    VStack {
                        Button(action: {
                            navigation.push(.tabbar)
                        }, label: {
                            Text("Go to feed")
                        })
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
                }
                .background(BackgroundLinearColor())
                .navigationDestination(for: PathCases.self) { path in
                AnyView(path.getView())
            }
               
              
        }  .environmentObject(navigation)
           
            .navigationBarBackButtonHidden(true)
       
       
        
      
        
        
        
        
    }
}
#Preview {
    ContentView()
}
