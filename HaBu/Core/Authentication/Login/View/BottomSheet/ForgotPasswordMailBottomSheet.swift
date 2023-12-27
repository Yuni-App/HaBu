//
//  showingForgotPassword.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI
import Firebase

struct ForgotPasswordMailBottomSheet: View {
    @StateObject var loginVM : LoginViewModel
    init(){
        self._loginVM = StateObject(wrappedValue: LoginViewModel(authService: AuthService()))
    }
    var body: some View {
        
            VStack{
                Text("Lütfen mail adresinizi giriniz.").foregroundStyle(.black).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 20))
                TextFields.CustomTextField(text: $loginVM.textForgotEmail, icon: .mail, placeHolder: "email")
                Buttons.GecilecekOlancustomButton(title: "Onayla", buttonColor: Const.primaryButtonColor,size: .xsmall) {
                    Task {
                       await loginVM.resetPassword()
                    }
                }
            }.padding(30)
                .alert(isPresented: $loginVM.showAlert) {
                    Alert(title: Text("Bilgi"), message: Text(loginVM.alertMessage), dismissButton: .default(Text("Tamam")))
                }
                .frame(width: Const.width , height:  Const.height)
                .background(
                    Const.authBackGroundColor
                )
        
    }

}

#Preview {
    ForgotPasswordMailBottomSheet()
}
