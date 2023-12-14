//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {   
    @State private var showingForgotPassword = false
    @Environment(\.dismiss) var dissmis
    @State private var textEmail : String = ""
    @State private var textPassword : String = ""    
    var body: some View {
            ZStack {
                VStack{
                    Buttons.backButton {
                        dissmis()
                        
                    }
                    .padding(.trailing,Const.width * 0.9)
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.loginVector)
                        VStack{
                            TextFields.CustomTextField(text: $textEmail, icon: .mail, placeHolder: "e-posta")
                            TextFields.CustomTextField(text: $textPassword , icon: .key, placeHolder: "Şifre")
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
                                
                            }, size: .small, textColor: .white, destination:AnyView(TabbarView()))
                            
                          
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .modifier(RectangleBlurModifier(color: Const.primaryColor))
                       
                    
                    HStack{
                        Text("Bir hesabınız yok mı?").foregroundStyle(.black).font(.system(size: 14))
                        
                        NavigationLink {
                            RegisterBuildFirstView().navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Kayıt Ol").foregroundStyle(.blue).fontWeight(.bold)

                        }
                        
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
