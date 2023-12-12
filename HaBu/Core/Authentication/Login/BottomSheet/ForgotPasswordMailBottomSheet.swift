//
//  showingForgotPassword.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordMailBottomSheet: View {
    @Binding var showSheet: Bool
    @State private var textEmail : String = ""
    var body: some View {
        NavigationStack{
            VStack{
                Text("Lütfen mail adresinizi giriniz.").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
                TextFields.CustomTextField(text: $textEmail, icon: .mail, placeHolder: "email")
                
                CustomButton(title: "Onay Kodu Gönder", backgroundColor: Const.primaryColor, action: {
                    true
                    //mail check
                },destination: AnyView(ForgotPasswordCodeBottomSheet(showSheet: $showSheet ).navigationBarBackButtonHidden(true)), size: CustomButtonSize.small)
                
            }.padding(30)
                .frame(width: Const.width , height:  Const.height)
                .background(
                    Const.authBackGroundColor
                )
        }
    }
}

#Preview {
    ForgotPasswordMailBottomSheet(showSheet: .constant(false))
}
