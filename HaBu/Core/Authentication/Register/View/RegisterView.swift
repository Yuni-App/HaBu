//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dissmis
   
    @StateObject var registerVM : RegisterViewModel
    init(){
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(authService: AuthService()))
    }
    var body: some View {
        ZStack {
            VStack{
                Buttons.backButton {
                    dissmis()
                }
                .padding(.trailing,Const.width * 0.9)
                CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.RegisterSecondVector)
                VStack{
                    TextFields.CustomTextField(text: $registerVM.textEmail, icon: .mail, placeHolder: "e-posta")
                    TextFields.CustomTextField(text :$registerVM.textPassword ,icon: .key, placeHolder: "Şifre")
                    TextFields.CustomTextField(text : $registerVM.textAgainPassword , icon: .key, placeHolder: "Şifre Tekrar")
                    TextFields.CustomTextField(text : $registerVM.textUserName , icon: .blocked, placeHolder: "Kullanıcı Adı")
                    Buttons.customButton(title: "Kayıt Ol", buttonColor: Const.secondaryColor , textColor: .black ) {
                        Task{
                         await registerVM.register()
                        }
                    }
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.42)
                    .modifier(RectangleBlurModifier(color: Const.primaryColor))
                HStack{
                    CheckBoxView(checked: registerVM.isChecked){
                        registerVM.isChecked.toggle()
                    }
                    Text("Lütfen").foregroundStyle(.black).font(.system(size: 13))
                    Button(action: {
                       
                        //open  bottomsheet
                    }, label: {
                        Text("Gizlilik Politikası").foregroundStyle(.blue).fontWeight(.bold).font(.system(size: 13))
                    })
                    Text("Onaylayınız").foregroundStyle(.black).font(.system(size: 13))
                }
                HStack{
                    Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 13))
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Giriş Yap").foregroundStyle(.blue).fontWeight(.bold).font(.system(size: 13))
                    }
                }
                
            }.frame(width: Const.width , height: Const.height+100)
            .disabled(registerVM.isRegistering) 
            
                if registerVM.isRegistering {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                        .padding()
                                }
            
        }.background(
            Const.authBackGroundColor
        )
        .alert(isPresented: $registerVM.showAlert) {
                   Alert(title: Text(registerVM.alertTitle), message: Text( registerVM.alertMessage), dismissButton: .default(Text("Tamam")))
               }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
