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
        NavigationStack{
            ZStack {
                VStack{
                    CustomImageRectangle(width: 537, height: 400, imagePath: ImageManager.registerVector)
                    CustomTextField(icon: "mail", placeHolder: "e-posta")
                    CustomTextField(icon: "key", placeHolder: "Şifre")
                    HStack{
                        Spacer()
                        Text("Şifremi unuttum.")
                            .padding()
                        
                            .onTapGesture {
                                showingForgotPassword = true
                                //  Bottomsheet will openSheet
                                print("Şifremi unuttum ")
                            }
                            .sheet(isPresented: $showingForgotPassword) {
                                ForgotPasswordBottomSheet()
                                    .presentationDetents([.large,.medium])
                            }
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                    
                    HStack{
                        Spacer()
                        CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                            //will delete the back button from feedview
                            print("cliked login button")
                        }, destinaiton: AnyView(TabbarView()),width: Const.width/3)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack{
                        Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{  Text("Giriş Yap").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                    }
                    Spacer()
                }.padding(30)
                    .frame(width: Const.width, height: 900)
                    .background(
                        BackgroundLinearColor()
                    )
            }
            
        }
        
    }
}
#Preview {
    LoginView()
}


