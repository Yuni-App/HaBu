//
//  DeleteAccountView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct DeleteAccountPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var textPassword : String = ""
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Hesabı Sil")
            ScrollView{
                VStack{
                    Text("Hesabınızı Silmek için Şifrenizi Giriniz ").fontWeight(.bold)
                    TextFields.CustomTextField3(text : $textPassword ,icon: .key, placeHolder: "şifre")
                }.padding()
                warningText()
            }
            CustomButton(title: "Kodu Gönder", backgroundColor: Const.secondaryButtonColor, action: {
                true
                //send kode
            }, destination: AnyView(DeleteAccountCodeView()), size: CustomButtonSize.medium)
        }    .navigationBarBackButtonHidden(true)
            .background(
                Const.primaryBackGroundColor
            )
    }
}

#Preview {
    DeleteAccountPasswordView()
}
@ViewBuilder
func warningText()->some View {
    VStack{
        HStack{
            Image.iconManager(AppIcon.warning, size: 35, weight: .bold, color: .red)
            Text("UYARI").fontWeight(.bold).foregroundColor(.red)
            Spacer()
        }
        Text("Silinen hesaplar saklanmaz tekrar giriş yapmak için tekrardan kayıt olmanız gerekmektedir.").fontWeight(.bold)
    }.padding()
}
