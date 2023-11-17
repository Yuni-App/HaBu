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
                Button(action: {
                    showSheet = false
                    goPage = true
                }, label: {
                    Text("Oluştur").padding()
                        .frame(width: Const.width-130  ,height: 30 )
                        .background(Const.primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                })
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


