//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {   
    @State private var showingForgotPassword = false
    @EnvironmentObject var navigation : NavigationStateManager
   
    
    var body: some View {
            ZStack {
                VStack{
                    Buttons.backButton {
                        navigation.pop()
                    }
                    .padding(.trailing,Const.width * 0.9)
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.loginVector)
                        VStack{
                            TextFields.CustomTextField(icon: .mail, placeHolder: "e-posta")
                            TextFields.CustomTextField(icon: .key, placeHolder: "Şifre")
                            HStack{
                                Spacer()
                                Text("Şifremi unuttum.")
                                    .padding()
                                    .onTapGesture {
                                        showingForgotPassword = true
                                        print("Şifremi unuttum ")
                                    }
                                    .sheet(isPresented: $showingForgotPassword) {
                                        ForgotPasswordMailBottomSheet(showSheet: $showingForgotPassword )
                                            .presentationDetents([.medium,.height(CGFloat(Const.height/4 + 10))])
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                            }
                            Buttons.customButton1(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                                navigation.push(.tabbar)
                            }, size: .small, textColor: .white)
                            
                          
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                       
                    
                    HStack{
                        Text("Bir hesabınız yok mı?").foregroundStyle(.black).font(.system(size: 14))
                        
                        Button(action: {
                            if navigation.path.last != .auth(.infoView)
                            {
                                navigation.pop()
                            }
                            else{
                                navigation.push(.auth(.register(.first)))
                            }
                        }, label: {
                            Text("Kayıt Ol").fontWeight(.bold)
                        })
                        
                    }
                    //TODO : update 100
                } .frame(width: Const.width , height: Const.height+100)
                    .padding()
                    
                    
            }.background(
                Const.authBackGroundColor
            )
            .navigationBarBackButtonHidden(true)
        
    }
}
#Preview {
    LoginView()
}
