//
//  SettingsView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
            VStack{
                CustomSettingsTollBar(action: {
                    dismiss()
                }, title: "Ayarlar")
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
            }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    SettingsView()
}


@ViewBuilder
private func SettingsTile(icon : AppIcon , text : String , destination : AnyView)->some View {
    NavigationLink {
      AnyView(destination)
    } label: {
        HStack{
            Image.iconManager(icon, size: 30, weight: .bold, color: .black)
            Text(text).fontWeight(.bold).foregroundColor(.black)
            Spacer()
            Image.iconManager(AppIcon.next, size: 30, weight: .bold, color: .black)
        }.padding(10)
    }

}


 @ViewBuilder
private func UserAboutBox() ->some View {
    VStack{
        Text("Kullanıcı Bilgileri").frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black.opacity(0.7))
            .fontWeight(.bold)
        VStack{
            SettingsTile(icon: AppIcon.person, text: "Profili Düzenle", destination: AnyView(EditProfileView(user: User.MockData[0])))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.lock, text: "Şifreyi Değiştir",destination: AnyView(ChangePasswordView()))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.blocked, text: "Engellenen Kullanıcılar",destination: AnyView(BlockedUsersView()))
            Divider().frame(width: Const.width * 0.84)
            SettingsTile(icon: AppIcon.savePost, text: "Kaydedilenler ",destination: AnyView(SavedPostView()))
        }.frame(maxWidth: .infinity, alignment: .leading)
            .background(
                .white
            ).cornerRadius(7)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
    }
}

@ViewBuilder
private func AppAboutBox() ->some View {
    VStack{
        Text("Uygulama Hakkında").frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black.opacity(0.7))
            .fontWeight(.bold)
        VStack{
            SettingsTile(icon: AppIcon.feedBack, text: "Geri Bildirim",destination: AnyView(FeedBackInput()))
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
private func OtherBox() -> some View {
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
