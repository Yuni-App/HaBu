//
//  SettingsView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            VStack{
                CustomSettingsTollBar(title: "Ayarlar", destinaiton: AnyView(TabbarView()))
                    ScrollView{
                        UserAboutBox()
                        AppAboutBox()
                        OtherBox()
                        Text("Uygulama Sürümü 1.0.0").foregroundColor(.black.opacity(0.3))
                    }
                .padding()
                .frame(width: Const.width)
                .background(
                    Const.primaryBackGroundColor
                )
            }
        }
    }
}

#Preview {
    SettingsView()
}


@ViewBuilder
func SettingsTile(icon : AppIcon , text : String , destination : AnyView)->some View {
    NavigationLink {
      AnyView(destination).navigationBarBackButtonHidden(true)
    } label: {
        HStack{
            Image.iconManager(icon, size: 30, weight: .bold, color: .black)
            Text(text).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.black)
            Spacer()
            Image.iconManager(AppIcon.next, size: 30, weight: .bold, color: .black)
        }.padding(10)
    }

}


@ViewBuilder
func UserAboutBox() ->some View {
    VStack{
        Text("Kullanıcı Bilgileri").frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black.opacity(0.7))
            .fontWeight(.bold)
        VStack{
            SettingsTile(icon: AppIcon.person, text: "Profili Düzenle", destination: AnyView(EditProfileView(data: .init(user: User.MockData[0]))))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.lock, text: "Şifreyi Değiştir",destination: AnyView(ChangePasswordView()))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.point, text: "Puanlarım",destination: AnyView(BlockedUsers()))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.blocked, text: "Engellenen Kullanıcılar",destination: AnyView(BlockedUsers()))
        }.frame(maxWidth: .infinity, alignment: .leading)
            .background(
                .white
            ).cornerRadius(7)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
    }
}

@ViewBuilder
func AppAboutBox() ->some View {
    VStack{
        Text("Uygulama Hakkında").frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black.opacity(0.7))
            .fontWeight(.bold)
        VStack{
            SettingsTile(icon: AppIcon.feedBack, text: "Geri Bildirim",destination: AnyView(BlockedUsers()))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.book, text: "Gizlilik Sözleşmesi",destination: AnyView(AgreementView()))
        }.frame(maxWidth: .infinity, alignment: .leading)
            .background(
                .white
            ).cornerRadius(7)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
    }
    .padding(.top , 5)
}





@ViewBuilder
func OtherBox() -> some View {
    VStack{
        Text("Diğer").frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black.opacity(0.7))
            .fontWeight(.bold)
        VStack{
            SettingsTile(icon: AppIcon.logout, text: "Çıkış Yap",destination: AnyView(InfoView()))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.trash, text: "Hesabı Sil",destination: AnyView(DeleteAccountPasswordView()))
        }.frame(maxWidth: .infinity, alignment: .leading)
            .background(
                .white
            ).cornerRadius(7)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
    }.padding(.top , 5)
}
