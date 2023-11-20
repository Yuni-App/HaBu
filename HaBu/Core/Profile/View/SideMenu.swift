//
//  SideMenu.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct myDivider: View{
    var body: some View{
        Rectangle()
            .background(Color.black)
            .frame(height: 1).bold()
    }
}

struct SideMenu: View {
    var body: some View {
        VStack {
            Spacer()
            NavigationLink {
                EditProfileView()
            } label: {
                Text("Ayarlar").foregroundColor(.white)
                    .font(.title3)
            }
            .frame(height: 50)
            myDivider()
            NavigationLink {
                EditProfileView()
            } label: {
                Text("Engellene kullanıcılar").foregroundColor(.white)
                    .font(.title3)
            }
            .frame(height: 50)
            myDivider()
            NavigationLink {
                EditProfileView()
            } label: {
                Text("Puanlarım").foregroundColor(.white)
                    .font(.title2)
            }
            .frame(height: 50)
            myDivider()
            NavigationLink {
                EditProfileView()
            } label: {
                Text("Geri Bildirim").foregroundColor(.white)
                    .font(.title2)
                
            }
            .frame(height: 50)
            myDivider()
            NavigationLink {
                EditProfileView()
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

#Preview {
    SideMenu()
}
