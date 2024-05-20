//
//  SettingsView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct SettingsView: View {
    var user: User
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Ayarlar")
                ScrollView{
                    UserAboutBox(user: user)
                    AppAboutBox()
                    OtherBox()
                    Text("Uygulama Sürümü 1.0.0").foregroundColor(.black.opacity(0.3))
                }
            .padding()
            .frame(width: Const.width)
            .background(
                Const.primaryBackGroundColor
            )
        }.navigationBarBackButtonHidden(true)
        
    }
    
    struct SettingsTile: View {

       let destination: () -> any View
       var icon : AppIcon
       var text : String
       var body: some View {
           NavigationLink {
               AnyView(destination())
           } label: {
               HStack{
                   Image.iconManager(icon, size: 30, weight: .bold, color: .black)
                   Text(text).fontWeight(.bold).foregroundColor(.black)
                   Spacer()
                   Image.iconManager(AppIcon.next, size: 30, weight: .bold, color: .black)
               }.padding(10)           }
       }
   }
   
    struct UserAboutBox: View {
        var user: User
        var body: some View {
            VStack{
                Text("Kullanıcı Bilgileri").frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black.opacity(0.7))
                    .fontWeight(.bold)
                VStack{
                    SettingsTile(destination: {
                        AnyView(EditProfileView(user: user))
                    },icon: AppIcon.person, text: "Profili Düzenle")
                    Divider().frame(width: Const.width * 0.84)
                    SettingsTile(destination: {
                        ChangePasswordView()}, icon: AppIcon.lock, text: "Şifreyi Değiştir")
                    Divider().frame(width: Const.width * 0.84)
                    /* SettingsTile(destination: {
                        BlockedUsersView()
                    }, icon: AppIcon.blocked, text: "Engellenen Kullanıcılar")
                    Divider().frame(width: Const.width * 0.84)  */
                    SettingsTile(destination: {
                        SavedPostView()
                    }, icon: AppIcon.savePost, text: "Kaydedilenler ")
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        .white
                    ).cornerRadius(7)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
            }
        }
    }
    
    @ViewBuilder
    private func AppAboutBox() ->some View {
        VStack{
            Text("Uygulama Hakkında").frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black.opacity(0.7))
                .fontWeight(.bold)
            VStack{
                SettingsTile(destination: {
                    FeedBackInput()
                }, icon: AppIcon.feedBack, text: "Geri Bildirim")
                Divider().frame(width: Const.width * 0.84)
                 SettingsTile(destination: {
                    NotificationSettings()
                }, icon: AppIcon.blocked, text: "Bildirim Ayarları")
                Divider().frame(width: Const.width * 0.84)
                SettingsTile(destination: {
                    AgreementView()
                }, icon: AppIcon.book, text: "Gizlilik Sözleşmesi")
              
            }.frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    .white
                ).cornerRadius(7)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
        }
        .padding(.top , 5)
    }





    @ViewBuilder
    private func OtherBox() -> some View {
        VStack{
            Text("Diğer").frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black.opacity(0.7))
                .fontWeight(.bold)
            VStack{
                SettingsTile(destination: {LogOutView()}, icon: AppIcon.logout, text: "Çıkış Yap")
                Divider().frame(width: Const.width * 0.84)
                SettingsTile(destination : {
                    DeleteAccountPasswordView()
                }, icon: AppIcon.trash, text: "Hesabı Sil")
            }.frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    .white
                ).cornerRadius(7)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
        }.padding(.top , 5)
    }

}

#Preview {
    SettingsView(user: User.MockData[0])
}


