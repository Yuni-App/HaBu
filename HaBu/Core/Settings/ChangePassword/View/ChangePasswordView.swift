//
//  ChangePasswordView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel = ChangePasswordViewModel()
    @State var eyehidden = true
    @State var eyehidden2 = true
    @State var eyehidden3 = true
    
    
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Şifre Değiştir")
            
            ScrollView{
                VStack{
                    HStack{
                        Text("En az 8 karakter uzunluğunda şifrenizi oluşturun. ").fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Image.iconManager(.info, size: 30, weight: .bold, color: Const.textColorSecondary)
                        Text("Şifre nasıl olmalıdır ? ").fontWeight(.bold).foregroundColor(Const.textColorSecondary)
                        Spacer()
                    }.padding(.vertical , 15)
                    TextFields.ChangeTextField(text: $viewModel.textPassword, icon: .key, placeHolder: "Mevcut şifrenizi giriniz", hidden: $eyehidden)
                    TextFields.ChangeTextField(text: $viewModel.textNewPassword,icon: .key, placeHolder: "Yeni şifre oluşturunuz", hidden: $eyehidden2)
                    TextFields.ChangeTextField(text: $viewModel.textNewPasswordAgain,icon: .key, placeHolder: "Şifreyi tekrar  giriniz", hidden: $eyehidden3)
                }.padding()
                Spacer()
                Buttons.customButton(title: "Değiştir", buttonColor: Const.primaryButtonColor) {
                    viewModel.updatePassword()
                    }
            }
            
        }.navigationBarBackButtonHidden(true)
            /*.navigationDestination(isPresented: $viewModel.isActiveDestination, destination: {
                ChangePasswordSuccessView()
            })*/
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(viewModel.alertTitle!), message: Text(viewModel.alertMessage!), dismissButton: .default(Text("Tamam")))
            }
            .background(Const.primaryBackGroundColor)
    }
}

#Preview {
    ChangePasswordView()
}
