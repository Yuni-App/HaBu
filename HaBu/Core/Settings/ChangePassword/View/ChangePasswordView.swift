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
                    ChangeTextField(text: $viewModel.textPassword, title: "Mevcut Şifre", placeHolder: "Mevcut şifrenizi giriniz")
                    ChangeTextField(text: $viewModel.textNewPassword,title: "Yeni Şifre", placeHolder: "Yeni şifre oluşturunuz")
                    ChangeTextField(text: $viewModel.textNewPasswordAgain,title: "Yeni Şifre Tekrar", placeHolder: "Şifreyi tekrar  giriniz")
                }.padding()
                
            }
            Buttons.customButton(title: "Değiştir", buttonColor: Const.primaryButtonColor) {
                viewModel.updatePassword()
                $viewModel.isActiveDestination }
        }.navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $viewModel.isActiveDestination, destination: {
                ChangePasswordSuccessView()
            })
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(viewModel.alertTitle!), message: Text(viewModel.alertMessage!), dismissButton: .default(Text("Tamam")))
            }
            .background(Const.primaryBackGroundColor)
    }
}

#Preview {
    ChangePasswordView()
}
@ViewBuilder
private func ChangeTextField(text: Binding<String> ,title : String , placeHolder : String)->some View{
    VStack {
        HStack{
            Text(title).fontWeight(.bold)
            Spacer()
        }
        TextFields.CustomTextField3(text: text, icon: .key, placeHolder: placeHolder)
    }.padding(.vertical , 7)
    
    
}
