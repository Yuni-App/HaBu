//
//  ChangePasswordView.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI

struct ChangePasswordView: View {
    var body: some View {
        VStack{
          CustomSettingsTollBar(title: "Şifre Değiştir",destinaiton: AnyView(SettingsView()))
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
                    TextFieldStack(title: "Mevcut Şifre", placeHolder: "Mevcut şifrenizi giriniz")
                    TextFieldStack(title: "Yeni Şifre", placeHolder: "Yeni şifre oluşturunuz")
                    TextFieldStack(title: "Yeni Şifre Tekrar", placeHolder: "Şifreyi tekrar  giriniz")
                }.padding()
            }
            CustomButton(title: "Değiştir", backgroundColor: Const.secondaryButtonColor, action: {
                true
                //send kode
            }, destination: AnyView(ChangePasswordSuccessView().navigationBarBackButtonHidden(true)), size: CustomButtonSize.medium)
        }.frame(width: Const.width)
            .background(
                Const.primaryBackGroundColor
            )
    }
}

#Preview {
    ChangePasswordView()
}
@ViewBuilder
func TextFieldStack(title : String , placeHolder : String)->some View{
    VStack {
        HStack{
            Text(title).fontWeight(.bold)
            Spacer()
        }
        CustomTextField3(icon: .key, placeHolder: placeHolder)
    }.padding(.vertical , 7)
 
    
}
