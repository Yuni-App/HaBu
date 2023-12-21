//
//  DeleteAccountCodeView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct DeleteAccountCodeView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var textCode: String = ""
    
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Hesabı Sil")
            ScrollView{
                VStack{
                    Text("Hesabınızı Silmek İçin Mailinize Gelen Kodu Giriniz").fontWeight(.bold)
                    TextFields.CustomTextField3(text: $textCode,icon: .code, placeHolder: "Kod")
                }.padding()
                warningText()
            }
            Buttons.customButton1(title: "Hesabı Sil", backgroundColor: Const.secondaryButtonColor, action: {
                true
               //delete account
            }, size: .medium, destination: {InfoView()})
        }
        .navigationBarBackButtonHidden(true)
        .frame(width: Const.width)
        .background(
            Const.primaryBackGroundColor
        )
    }
}

#Preview {
    DeleteAccountCodeView()
}
