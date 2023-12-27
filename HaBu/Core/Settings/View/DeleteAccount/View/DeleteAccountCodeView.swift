//
//  DeleteAccountCodeView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct DeleteAccountCodeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isActiveDestination: Bool = false
    @StateObject var deleteAccountVM : DeleteAccountViewModel
    init(){
        self._deleteAccountVM = StateObject(wrappedValue: DeleteAccountViewModel())
    }
 
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Hesabı Sil")
            ScrollView{
                VStack{
                    Text("Hesabınızı Silmek İçin Mailinize Gelen Kodu Giriniz").fontWeight(.bold)
                    TextFields.CustomTextField3(text: $deleteAccountVM.textCode,icon: .code, placeHolder: "Kod")
                }.padding()
                warningText()
            }
            Buttons.customButton(title: "Hesabı Sil", buttonColor: Const.secondaryButtonColor) {
                isActiveDestination = true
            }
           
        }
        .navigationDestination(isPresented: $isActiveDestination, destination: {
            InfoView()
        })
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
