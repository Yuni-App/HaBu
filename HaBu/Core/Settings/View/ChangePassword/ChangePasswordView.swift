//
//  ChangePasswordView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var textPassword: String = ""
    @State private var textNewPassword : String = ""
    @State private var textNewPasswordAgain : String = ""
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
                    ChangeTextField(text: $textPassword, title: "Mevcut Şifre", placeHolder: "Mevcut şifrenizi giriniz")
                    ChangeTextField(text: $textNewPassword,title: "Yeni Şifre", placeHolder: "Yeni şifre oluşturunuz")
                    ChangeTextField(text: $textNewPasswordAgain,title: "Yeni Şifre Tekrar", placeHolder: "Şifreyi tekrar  giriniz")
                }.padding()
                
            }
            Buttons.customButton(title: "Değiştir", backgroundColor: Const.primaryButtonColor, action: {
                true
                //send kode
            }, destination: AnyView(ChangePasswordSuccessView().navigationBarBackButtonHidden(true)), size: CustomButtonSize.medium)
        }   .navigationBarBackButtonHidden(true)
            .background(
                Const.primaryBackGroundColor
            )
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
