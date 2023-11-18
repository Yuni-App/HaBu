//
//  ForgotPasswordCodeBottomSheet.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct ForgotPasswordCodeBottomSheet: View {
    @Binding var showSheet: Bool
    @Binding var goPage: Bool

    var body: some View {
        NavigationStack{  VStack{
            Text("Lütfen kodu  giriniz.").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
            CustomTextField(icon: "key", placeHolder: "kod")
            CustomLinkButton(title: "Onayla", backgroundColor: Const.primaryColor, action: {
            },destinaiton: AnyView(ForgotPasswordCreatePasswordBottomSheet(showSheet: $showSheet , goPage: $goPage)))
        }.padding(30)
                .frame(width: Const.width , height:  Const.height)
                .background(
                    BackgroundLinearColor()
                )
        }
    }
}
#Preview {
    ForgotPasswordCodeBottomSheet(showSheet: .constant(false), goPage: .constant(false))
}


