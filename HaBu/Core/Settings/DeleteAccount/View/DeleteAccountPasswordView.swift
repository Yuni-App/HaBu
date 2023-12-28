//
//  DeleteAccountView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct DeleteAccountPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var deleteAccountVM : DeleteAccountViewModel
    @State private var isActiveDestination: Bool = false

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
                    Text("Hesabınızı Silmek için Şifrenizi Giriniz ").fontWeight(.bold)
                    TextFields.CustomTextField3(text : $deleteAccountVM.textPassword ,icon: .key, placeHolder: "şifre")
                }.padding()
                warningText()
            }
            Buttons.customButton(title: "Kodu GÖnder", buttonColor: Const.secondaryButtonColor) {
                isActiveDestination = true
            }
        }
        .navigationDestination(isPresented: $isActiveDestination, destination: {
            DeleteAccountCodeView()
        })
        .navigationBarBackButtonHidden(true)
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
