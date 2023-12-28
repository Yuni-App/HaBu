//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dissmis
    @StateObject var loginVM : LoginViewModel
    init(){
        self._loginVM = StateObject(wrappedValue: LoginViewModel(authService: AuthService()))
    }
    var body: some View {
        ZStack {
            VStack{
                Buttons.backButton{
                    dissmis()
                }
                .padding(.trailing,Const.width * 0.9)
                CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.loginVector)
                VStack{
                    TextFields.CustomTextField(text: $loginVM.textEmail, icon: .mail, placeHolder: "e-posta")
                    TextFields.CustomTextField(text: $loginVM.textPassword , icon: .key, placeHolder: "Şifre")
                    HStack{
                        Spacer()
                        Text("Şifremi unuttum.")
                            .padding()
                            .onTapGesture {
                                loginVM.showingForgotPassword.toggle()
                                print("Şifremi unuttum ")
                            }
                            .sheet(isPresented: $loginVM.showingForgotPassword) {
                                ForgotPasswordMailBottomSheet()
                                    .presentationDetents([.medium,.height(CGFloat(Const.height/4 + 10))])
                            }
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                    Buttons.customButton(title: "Giriş Yap", buttonColor: Const.secondaryColor , textColor: .black ) {
                        Task{
                            loginVM.isActiveDestination =   await loginVM.signIn()
                        }
                    }
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                    .modifier(RectangleBlurModifier(color: Const.primaryColor))
                HStack{
                    Text("Bir hesabınız yok mı?").foregroundStyle(.black).font(.system(size: 14))
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Kayıt Ol").foregroundStyle(.blue).fontWeight(.bold)
                        
                    }
                }
            } .frame(width: Const.width , height: Const.height+100)
                .padding()
                .navigationDestination(isPresented: $loginVM.isActiveDestination, destination: {
                    TabbarView()
                })
                .alert(isPresented: $loginVM.showAlert) {
                    Alert(title: Text(loginVM.alertTitle), message: Text( loginVM.alertMessage), dismissButton: .default(Text("Tamam")))
                }.background(Const.authBackGroundColor)
                .navigationBarBackButtonHidden(true)
        }
    }
}
#Preview {
    LoginView()
}
