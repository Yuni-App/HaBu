//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {   
    @State private var showingForgotPassword = false
    @State private var goPage = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    CustomImageRectangle(width: Const.width, height: Const.height/2, imagePath: ImageManager.loginVector)
                    ZStack{
                        Image("")
                            .frame(width: 370, height: 260)
                            .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                        VStack{
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
                                        ForgotPasswordMailBottomSheet(showSheet: $showingForgotPassword , goPage: $goPage)
                                            .presentationDetents([.medium,.height(CGFloat(Const.height/4 + 10))])
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                            }
                            
                            CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                                //will delete the back button from feedview
                                print("cliked login button")
                            }, destinaiton: AnyView(TabbarView())).padding(.vertical , 30)
                        }
                    }
                    HStack{
                        Text("Bir hesabınız yok mı?").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            RegisterBuildFirstView()
                        } label: {
                            HStack{  Text("Kayıt Ol").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                        }
                    }
                }.padding()
                    .frame(width: Const.width, height: 1000)
                    .background(
                        BackgroundLinearColor()
                    )
            }.background(
                NavigationLink("", destination: TabbarView(), isActive: $goPage).hidden()
            )
            
        }
        
    }
}
#Preview {
    LoginView()
}


