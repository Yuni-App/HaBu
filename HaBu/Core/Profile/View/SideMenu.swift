//
//  SideMenu.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowingSideMenu :Bool
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    isShowingSideMenu = false
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(.trailing,20)
                })
            }
            Spacer()
            NavigationLink {
                EditProfileView(user:User.MockData[0])
            } label: {
                Text("Ayarlar").foregroundColor(.white)
                    .font(.title3)
            }
            .frame(height: 50)
            NavigationLink {
                EditProfileView(user:User.MockData[0])
            } label: {
                Text("Engellene kullanıcılar").foregroundColor(.white)
                    .font(.title3)
            }
            .frame(height: 50)
            NavigationLink {
                EditProfileView(user:User.MockData[0])
            } label: {
                Text("Puanlarım").foregroundColor(.white)
                    .font(.title2)
            }
            .frame(height: 50)
            NavigationLink {
                EditProfileView(user:User.MockData[0])
            } label: {
                Text("Geri Bildirim").foregroundColor(.white)
                    .font(.title2)
            }
            .frame(height: 50)
            NavigationLink {
                EditProfileView(user:User.MockData[0])
            } label: {
                Text("Çıkış Yap").foregroundColor(.white)
                    .font(.title2)
            }
            .frame(height: 50)
            
            Spacer()
        }
        .frame(width: 175)
        .background(Color(red: 0.36, green: 0.51, blue: 0.57))
        .edgesIgnoringSafeArea(.bottom)
    }
}

