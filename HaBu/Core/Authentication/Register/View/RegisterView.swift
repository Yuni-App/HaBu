//
//  RegisterBuildFirstView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

enum FocusableField2{
    case email, password,passwordAgain, userName
}


struct RegisterView: View {
    @Environment(\.dismiss) var dissmis
    @FocusState private var focusText : FocusableField2?
    @State var eyehidden = true
    @State var eyehidden2 = true
    
    @StateObject var registerVM : RegisterViewModel
    init(){
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(authService: AuthService()))
    }
    var body: some View {
        ZStack {
            VStack{
                VStack {
                    TextFields.CustomTitle(text: "Kayıt Ol", size: 50)
                    TextFields.CustomTitle(text: "Aramıza Hoşgeldin...", size: 25)
                    
                }.frame(height: Const.height * 0.35)
                VStack {
                    Divider().frame(width: Const.width * 0.6, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .leading)
                    Divider().frame(width: Const.width * 0.4, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .leading)
                }
                VStack{
                    TextFields.CustomTextField(text: $registerVM.textEmail, icon: .mail, placeHolder: "e-posta")
                        .focused($focusText, equals: .email)
                        .onSubmit {
                            focusText = .password
                        }
                    
                    TextFields.CustomTextFieldSecure(text :$registerVM.textPassword ,icon: .key, placeHolder: "Şifre", hidden: $eyehidden)
                        .focused($focusText, equals: .password)
                        .onSubmit {
                            focusText = .passwordAgain
                        }
                    
                    TextFields.CustomTextFieldSecure(text : $registerVM.textAgainPassword , icon: .key, placeHolder: "Şifre Tekrar", hidden: $eyehidden2)
                        .focused($focusText, equals: .passwordAgain)
                        .onSubmit {
                            focusText = .userName
                        }
                    
                    TextFields.CustomTextField(text : $registerVM.textUserName , icon: .blocked, placeHolder: "Kullanıcı Adı")
                        .focused($focusText, equals: .email)
                        .onSubmit {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    
                    Buttons.customButton(title: "Kayıt Ol", buttonColor: Const.whiteColor , textColor: .black ) {
                        Task{
                            await registerVM.register()
                        }
                    }
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.42)
                    .modifier(RectangleBlurModifier(color: Const.rectangleColor))
                VStack {
                    Divider().frame(width: Const.width * 0.4, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .trailing)
                    Divider().frame(width: Const.width * 0.6, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .trailing)
                }
                Spacer()
                HStack{
                    CheckBoxView(checked: registerVM.isChecked){
                        registerVM.isChecked.toggle()
                    }.foregroundStyle(Color.white)
                    
                    TextFields.CustomText(text: "Lütfen", color: Const.textColor5, size: 13)
                    Button(action: {
                        
                        //open  bottomsheet
                    }, label: {
                        TextFields.CustomTextBold(text: "Gizlilik politikasını", color: Const.whiteColor, size: 13)
                    })
                    
                    TextFields.CustomText(text: "onaylayınız.", color: Const.textColor5, size: 13)
                }
                HStack{
                    TextFields.CustomText(text: "Bir hesabınız var mı?", color: Const.textColor5, size: 13)
                    NavigationLink {
                        LoginView()
                    } label: {
                        TextFields.CustomTextBold(text: "Giriş Yap", color: Const.whiteColor, size: 13)
                    }
                }
                Spacer()
            }.frame(width: Const.width , height: Const.height)
                .overlay(alignment: .topLeading, content: {
                    Buttons.backButton{
                        dissmis()
                    }.padding().padding(.top, Const.height * 0.03)
                })
            
            
            
            
        }.background(
            Const.primaryColor
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
