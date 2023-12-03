//
//  DeleteAccountCodeView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct DeleteAccountCodeView: View {
    var body: some View {
        VStack{
          CustomSettingsTollBar(title: "Hesabı Sil",destinaiton: AnyView(SettingsView()))
            ScrollView{
                VStack{
                    Text("Hesabınızı Silmek İçin Mailinize Gelen Kodu Giriniz").fontWeight(.bold)
                    CustomTextField3(icon: .code, placeHolder: "Kod")
                }.padding()
                WarningText()
            }
            CustomButton(title: "Hesabı Sil", backgroundColor: Const.secondaryButtonColor, action: {
                true
               //delete account
            }, destination: AnyView(InfoView().navigationBarBackButtonHidden(true)), size: CustomButtonSize.medium)
        }.frame(width: Const.width)
            .background(
                Const.primaryBackGroundColor
            )
    }
}

#Preview {
    DeleteAccountCodeView()
}
