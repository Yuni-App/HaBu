//
//  ForgotPasswordCreatePasswordBottomSheet.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordCreatePasswordBottomSheet: View {
    @Binding var showSheet: Bool
    @Binding var goPage: Bool
    var body: some View {
        NavigationStack {
            VStack{
                Text("Şifre Oluştur").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
                CustomTextField(icon: "key", placeHolder: "şifre")
                CustomTextField(icon: "key", placeHolder: "şifre tekrar")
                CustomButton(title: "Oluştur", backgroundColor: Const.primaryColor, action: {
                    showSheet = false
                    goPage = true
                    return false
                }, size: CustomButtonSize.small)
            }.padding(30)
                .frame(width: Const.width , height: Const.height)
                .background(
                    BackgroundLinearColor()
                )
        }
    }
}

#Preview {
    ForgotPasswordCreatePasswordBottomSheet(showSheet: .constant(false), goPage: .constant(false))
}


