//
//  showingForgotPassword.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordMailBottomSheet: View {
    @Binding var showSheet: Bool
    @Binding var goPage: Bool

    var body: some View {
        NavigationStack{
            VStack{
                Text("Lütfen mail adresinizi giriniz.").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
                CustomTextField(icon: "mail", placeHolder: "email")
                CustomLinkButton(title: "Onay Kodu Gönder", backgroundColor: Const.primaryColor, action: {
                    //mail check

                },destinaiton: AnyView(ForgotPasswordCodeBottomSheet(showSheet: $showSheet , goPage: $goPage)), size: CustomButtonSize.small)
                
            }.padding(30)
                .frame(width: Const.width , height:  Const.height)
                .background(
                    BackgroundLinearColor()
                )
        }
    }
}

#Preview {
    ForgotPasswordMailBottomSheet(showSheet: .constant(false), goPage: .constant(false))
}
