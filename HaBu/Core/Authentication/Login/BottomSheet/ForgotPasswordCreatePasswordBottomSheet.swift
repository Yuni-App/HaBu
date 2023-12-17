//
//  ForgotPasswordCreatePasswordBottomSheet.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordCreatePasswordBottomSheet: View {
    @Binding var showSheet: Bool
    @State var textPassword: String = ""
    @State var textPasswordAgain : String = ""

    var body: some View {
        NavigationStack {
            VStack{
                Text("Şifre Oluştur").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
                TextFields.CustomTextField(text: $textPassword, icon: .key, placeHolder: "şifre")
                TextFields.CustomTextField(text: $textPasswordAgain, icon:  .key, placeHolder: "şifre tekrar")
                Buttons.customButton(title: "Oluştur", backgroundColor: Const.primaryColor, action: {
                    showSheet = false
                    return false
                    
                }, size: CustomButtonSize.small)
            }.padding(30)
                .frame(width: Const.width , height: Const.height)
                .background(
                    Const.authBackGroundColor
                )
        }
    }
}

#Preview {
    ForgotPasswordCreatePasswordBottomSheet(showSheet: .constant(true))
}


