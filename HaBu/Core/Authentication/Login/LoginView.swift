//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {   
    @State private var showingForgotPassword = false
   
    
    var body: some View {
            ZStack {
                VStack{
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
                            CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                               true
                            }, destination: AnyView(TabbarView().navigationBarBackButtonHidden(true)), size: CustomButtonSize.small)
                        }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                       
                    
                    HStack{
                        Text("Bir hesabınız yok mı?").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            RegisterBuildFirstView()
                        } label: {
                            HStack{  Text("Kayıt Ol").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                    }
                    //TODO : update 100
                } .frame(width: Const.width , height: Const.height+100)
                    .padding()
                    
                    
            }.background(
                Const.authBackGroundColor
            )
        
    }
}
#Preview {
    LoginView()
}
