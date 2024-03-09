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
                    ChangeTextField(text: $viewModel.textPassword, icon: .key, placeHolder: "Mevcut şifrenizi giriniz", hidden: $eyehidden)
                    ChangeTextField(text: $viewModel.textNewPassword,icon: .key, placeHolder: "Yeni şifre oluşturunuz", hidden: $eyehidden2)
                    ChangeTextField(text: $viewModel.textNewPasswordAgain,icon: .key, placeHolder: "Şifreyi tekrar  giriniz", hidden: $eyehidden3)
                }.padding()
                Spacer()
                Buttons.customButton(title: "Değiştir", buttonColor: Const.primaryButtonColor) {
                    viewModel.updatePassword()
                    }
            }
            
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
private func ChangeTextField(text : Binding<String>,icon:AppIcon , placeHolder : String, hidden: Binding<Bool>)->some View{
    VStack {
        HStack(alignment: .center) {
            Image.iconManager(icon, size: 15, weight: .bold, color: .black)
            ZStack(alignment: .leading) {
                if text.wrappedValue.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(.black.opacity(0.6))
                }
                if hidden.wrappedValue {
                    SecureField("", text: text)
                        .foregroundColor(.black)
                } else {
                    TextField("", text: text)
                        .foregroundColor(.black)
                }
            }
            Button(action: {
                hidden.wrappedValue.toggle()
            }) {
                Image(systemName: hidden.wrappedValue ? "eye.fill" : "eye.slash")
                    .foregroundColor(.black)
            }
        }
        .frame(height: Const.height * 0.07)
        .padding(.horizontal, 10)
        .background(Const.whiteColor)
        .cornerRadius(10)
        
    }
    .padding(.vertical, 10)
}
