//
//  LoginView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

enum FocusableField: Hashable {
    case  email, password
}
struct LoginView: View {
    
    @Environment(\.dismiss) var dissmis
    @StateObject var loginVM : LoginViewModel
    @State private var isKeyboardHidden = true
    @State var eyehidden = true
    
    @FocusState private var focusedField: FocusableField?
    
    init(){
        self._loginVM = StateObject(wrappedValue: LoginViewModel(authService: AuthService()))
    }
    var body: some View {
        ZStack {
            VStack{
                
                VStack {
                    TextFields.CustomTitle(text: "Giriş", size: 50)
                    TextFields.CustomTitle(text: "Tekrardan Hoşgeldin...", size: 25)
                    
                }.frame(height: Const.height * 0.4)
                VStack {
                    Divider().frame(width: Const.width * 0.6, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .leading)
                    Divider().frame(width: Const.width * 0.4, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .leading)
                }
                
                VStack{
                    TextFields.CustomTextField(text: $loginVM.textEmail, icon: .mail, placeHolder: "e-posta")
                        .focused($focusedField, equals: .email)
                        .onSubmit {
                            focusedField = .password
                        }
                    TextFields.CustomTextFieldSecure(text: $loginVM.textPassword , icon: .key, placeHolder: "Şifre", hidden: $eyehidden)
                        .focused($focusedField, equals: .password)
                        .onSubmit {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    
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
                    Buttons.customButton(title: "Giriş Yap", buttonColor: Const.whiteColor , textColor: .black ) {
                        Task{
                            loginVM.isActiveDestination =   await loginVM.signIn()
                        }
                    }
                }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                    .modifier(RectangleBlurModifier(color: Const.rectangleColor))
                VStack {
                    Divider().frame(width: Const.width * 0.4, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .trailing)
                    Divider().frame(width: Const.width * 0.6, height: Const.height * 0.003).overlay(Color.white).frame(width: Const.width, alignment: .trailing) 
                }
                Spacer()
                HStack{
                    TextFields.CustomText(text: "Bir hesabınız yok mu?", color: Const.textColor5, size: 13)
                    NavigationLink {
                        RegisterView()
                    } label: {
                        TextFields.CustomTextBold(text: "Kayıt Ol", color: Const.whiteColor, size: 13)
                        
                    }
                }
                Spacer()
            }.frame(width: Const.width, height: Const.height)
                .overlay(alignment: .topLeading, content: {
                    Buttons.backButton{
                        dissmis()
                    }.padding().padding(.top, Const.height * 0.03)
                })
                
                
                .navigationDestination(isPresented: $loginVM.isActiveDestination, destination: {
                    TabbarView()
                })
                .alert(isPresented: $loginVM.showAlert) {
                    Alert(title: Text(loginVM.alertTitle), message: Text( loginVM.alertMessage), dismissButton: .default(Text("Tamam")))
                }.background(Const.primaryColor)
                .navigationBarBackButtonHidden(true)
                
        }
        .hideKeyboardOnTap()
        
    }
    
    
}
#Preview {
    LoginView()
}
