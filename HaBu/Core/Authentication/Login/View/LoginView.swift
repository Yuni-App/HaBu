//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dissmis
    @State private var isActiveDestination: Bool = false
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
                    Buttons.GecilecekOlancustomButton(title: "Giriş Yap", buttonColor: Const.secondaryColor , textColor: .black ) {
                       
                        loginVM.activeDestinaiton = AnyView(TabbarView())
                        Task{
                            isActiveDestination =   await loginVM.signIn()
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
                //TODO : update 100
            } .frame(width: Const.width , height: Const.height+100)
                .padding()

                .navigationDestination(isPresented: $isActiveDestination, destination: {
                    loginVM.activeDestinaiton
                })
               
                .popup(isPresented: $loginVM.error) {
                    PopUps.PopUp2(title: "Hata", contents: loginVM.errorMessage, size: .xxsmall, isPopUpPresented: $loginVM.error)
                }
        }.background(Const.authBackGroundColor)
        .navigationBarBackButtonHidden(true)
        
    }
}
#Preview {
    LoginView()
}
