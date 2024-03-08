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
    @StateObject var vm : LogOutViewModel
    @State var eyeHidden = true

    init(){
        self._deleteAccountVM = StateObject(wrappedValue: DeleteAccountViewModel())
        self._vm = StateObject(wrappedValue: LogOutViewModel(authService: AuthService()))
    }
    
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Hesabı Sil")
            ScrollView{
                VStack{
                    Text("Hesabınızı Silmek için Şifrenizi Giriniz ").fontWeight(.bold)
                    TextFields.ChangeTextField(text : $deleteAccountVM.textPassword ,icon: .key, placeHolder: "şifre", hidden: $eyeHidden)
                    
                }.padding()
                warningText()
            }
            Buttons.customButton(title: "Onayla", buttonColor: Const.secondaryButtonColor) {
                deleteAccountVM.deleteAccount { success, error in
                    if success {
                        Task{
                            isActiveDestination = await vm.logout()
                        } 
                    } else {
                        // handle error
                    }
                }
            }
        }
        .alert(isPresented: $deleteAccountVM.showingAlert) {
            Alert(title: Text(deleteAccountVM.alertTitle!), message: Text(deleteAccountVM.alertMessage!), dismissButton: .default(Text("Tamam")))
        }
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
