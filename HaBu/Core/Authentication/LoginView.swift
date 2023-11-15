//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {

    var body: some View {
        

        NavigationStack{
            VStack{
                Spacer()
                Spacer()
                CustomTextField(icon: "mail", placeHolder: "e-posta")
                CustomTextField(icon: "key", placeHolder: "Şifre")
                HStack{
                    Spacer()
                    Text("Şifremi unuttum.")
                        .padding()
                        .onTapGesture {
                          //  Bottomsheet will openSheet
                            print("Şifremi unuttum ")
                        }
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                HStack{
                    Spacer()
                    CustomButton(title: "Giriş Yap", backgroundColor: Const.primaryColor, action: {
                        //will delete the back button from feedview
                        print("cliked login button")
                    }, destinaiton: AnyView(FeedView()),width: Const.width/3)
                }
                Spacer()
                HStack{
                    Text("Bir hesabınız yok mu ?").foregroundStyle(.black).font(.system(size: 14))
                    NavigationLink {
                        RegisterBuildFirstView()
                    } label: {
                        HStack{  Text("Kayıt Ol").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                    }
                }
            }.padding(30)
        }
    }
}

#Preview {
    LoginView()
}


