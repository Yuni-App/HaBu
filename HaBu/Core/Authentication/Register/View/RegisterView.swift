//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dissmis
    @State private var isActiveDestination: Bool = false

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
                    Buttons.GecilecekOlancustomButton(title: "Kayıt Ol", buttonColor: Const.secondaryColor , textColor: .black ) {
                        registerVM.activeDestinaiton = AnyView(TabbarView())
                        Task{
                            isActiveDestination = await registerVM.register()
                        }
                    }
                    HStack{
                        Text("Bir hesabınız var mı?").foregroundStyle(.black).font(.system(size: 14))
                        
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Giriş Yap").foregroundStyle(.blue).fontWeight(.bold)
                            
                        }
                    }
                    
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.42)
                    .modifier(RectangleBlurModifier(color: Const.primaryColor))
               
                HStack{
                    CheckBoxView(checked: registerVM.isChecked){
                        registerVM.isChecked.toggle()
                    }
                    Text("Lütfen").foregroundStyle(.black).font(.system(size: 14))
                    Button(action: {
                       
                        //open  bottomsheet
                    }, label: {
                        Text("Gizlilik Politikası").foregroundStyle(.blue).fontWeight(.bold)
                    })
                    Text("Onaylayınız").foregroundStyle(.black).font(.system(size: 14))
                }
            }.frame(width: Const.width , height: Const.height+100)
        }.background(
            Const.authBackGroundColor
        )
        .popup(isPresented: $registerVM.error) {
            PopUps.PopUp2(title: "Hata", contents: registerVM.errorMessage, size: .xxsmall, isPopUpPresented: $registerVM.error)
        }
        .navigationDestination(isPresented: $isActiveDestination, destination: {
            registerVM.activeDestinaiton
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
